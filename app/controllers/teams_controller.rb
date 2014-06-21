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
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
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

        @team.logo = uploaded[1] and @team.save unless uploaded[0]

        format.html { redirect_to @team, notice: t('successfully_created_team') }
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
    @team = Team.find_by_captain_player_id current_user.player.id
    render layout: 'user'
  end
end
