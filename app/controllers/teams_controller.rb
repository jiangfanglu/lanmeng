class TeamsController < ApplicationController
  include ApplicationHelper
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html { render layout: 'user' }
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    redirect_to '/user' if @team.captain_player_id != current_user.player.id
    render layout: 'user'
  end

  def uploadlogo
    render layout: 'user'
  end

  def cropthumbnail
    #require 'fileutils'

      tmp = params[:thumbnail].tempfile
      ext = File.extname(params[:thumbnail].original_filename)

      file = File.join(TEMPORARY_FILE_FOLDER, "team-#{params[:id]}#{ext}".downcase)
      FileUtils.cp tmp.path, file
      #img = Magick::Image.read( file )

      image = MiniMagick::Image.open(file)
      w = image[:width].to_f
      h = image[:height].to_f
      ratio = w/h

      if w >= 600
        image.resize "600x#{((600/ratio).to_i).to_s}"
        image.write file
      end

      session[:tmp_thumb_image] = {
        :file=> file, 
        :filename=>Time.new.to_f.to_s.gsub(".",""), 
        :dimension=>{
          :width=>600,
          :height=>(600/ratio).to_i
          }}
      render layout: 'user'
  end

  def crop_image
    foldername = "team/#{params[:id]}/logo/"
    if gen_avartar(session[:tmp_thumb_image][:file], 
          params[:width].to_i,
          params[:height].to_i,
          params[:x].to_i,
          params[:y].to_i,
          params[:actual_width].to_i,
          150,
          "#{foldername}#{session[:tmp_thumb_image][:filename]}")
        
        # uploaded = upload_image_basic(params[:team]['logo'], filename, foldername)
          
          @team = Team.find params[:id]
          @team.logo = session[:tmp_thumb_image][:filename]
          @team.save

          session[:tmp_thumb_image] = nil

          render :text=>"OK",:layout=>false
      else
          render :text=>"Transfer failed",:layout=>false  
      end
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(
        name: params[:team]['name'],
        logo: "tempfilename",
        description: params[:team]['description'],
        member_count: params[:team]['member_count'].to_i,
        captain_player_id: params[:team]['captain_player_id'].to_i
      )

    respond_to do |format|
      if @team.save

        @player_team = PlayerTeam.new(
            player_id: current_user.player.id,
            team_id: @team.id
          )
        @team.member_count += 1 if @player_team.save

        @team_stat = TeamStat.new(
            team_id: @team.id,
            win: 0,
            lose: 0
          )
        @team_stat.save

        format.html { redirect_to action: 'captain_teams', id: 0 , notice: t('successfully_created_team') }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])

        format.html { redirect_to action: 'captain_teams', id: 0, notice: t('successfully_updated_team') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def captain_teams
    @team = Team.includes(:players).find_by_captain_player_id current_user.player.id

    @applications = TeamApplication.includes(:user).where("applied_team_id = ? and status = 0",@team.id )

    @weblog = Weblog.new

    render layout: 'user'
  end

  def jointeamrequestonhold
    cookies[:team_invited] = {value: params[:id], expires: 20.years.from_now.utc}
    redirect_to "/"
  end

  def invite
    @qqs = params[:invited].split(",")
    @qqs.each do |qq|
      Site.delay.inivte_friends(current_user.name, qq, params[:id])
    end
    render :text=>"OK", :layout=>false
  end

  def confirm_join
    @player_team = PlayerTeam.new(
        player_id: params[:id].split("_")[2].to_i,
        team_id: params[:id].split("_")[1].to_i
      )
    if @player_team.save
      TeamApplication.destroy params[:id].split("_")[3].to_i

      @team = Team.find params[:id].split("_")[1].to_i
      @team.member_count += 1

      redirect_to :action => "captain_teams", :id=>0 if @team.save
    end
  end

  def refuse_application

      @ta = TeamApplication.find params[:id].split("_")[3].to_i
      @ta.status = -1

      redirect_to :action => "captain_teams", :id=>0 if @ta.save
  end

  def remove_player
    PlayerTeam.destroy_all(["player_id = ? and team_id = ?",params[:id].split("_")[2], params[:id].split("_")[1]])
    @team = Team.find params[:id].split("_")[1].to_i
    @team.member_count -= 1
    redirect_to :action => "captain_teams", :id=>0 if @team.save
  end

  def apply_to_join
    redirect_to controller: "user", action: "login", id: 0 unless current_user

    @team_application = TeamApplication.new(
        applicant_user_id: current_user.id,
        applied_team_id: params[:id],
        status: 0
      )
    if @team_application.save
       cookies[:team_invited] = nil if cookies[:team_invited]
      redirect_to controller: 'teams', action: "my_team", id: 0, :applied=>1
    end
  end

  def my_team
    @team = current_user.player.teams.includes(:team_stat).includes(:tournaments).first
    unless @team.blank?
      @captain = Player.find @team.captain_player_id
      @weblogs = Weblog.where("user_id = ? and blog_type = 'T' ", @captain.user_id).order("created_at desc").limit(30)
    end
    render layout: 'user'
  end
end
