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
        foldername = "team/#{@team.id}/logo/"
        filename = Time.new.to_f.to_s.gsub(".","")
        uploaded = upload_image_basic(params[:team]['logo'], filename, foldername)

        @player_team = PlayerTeam.new(
            player_id: current_user.player.id,
            team_id: @team.id
          )
        @team.member_count += 1 if @player_team.save
        @team.logo = uploaded[1]
        
        @team.save unless uploaded[0]

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

        format.html { redirect_to @team, notice: t('successfully_updated_team') }
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

  def invite
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
    @team_application = TeamApplication.new(
        applicant_user_id: current_user.id,
        applied_team_id: params[:id],
        status: 0
      )
    if @team_application.save
      render controller: 'teams', action: "my_team", id: 0
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
