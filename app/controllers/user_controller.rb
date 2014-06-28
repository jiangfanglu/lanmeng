class UserController < ApplicationController
	include ApplicationHelper
	#layout 'user'
	before_filter :allowed, :only => [:login, :signup]
	skip_before_filter :verify_authenticity_token, :only => [:create]
	def index

	end

	def show
	end

	def volunteer
		@city = City.includes(:tournaments).find current_city
	end

	def referee
		@games = Game.where("referal_id = ? and time >= ?", current_user.referee.id, Time.now).order("created_at desc")
	end

	def join_referee
		@referee = Referee.new(
			name: current_user.name,
			game_count: 0,
			rating: 0,
			rating_count: 0,
			status: 1,
			user_id: current_user.id,
			tournament_id: params[:post][:tournament_id].to_i
		)
		@referee.save

		@tournament = Tournament.find params[:post][:tournament_id].to_i
		render :layout=>"user"
	end

	def edit
		@user = User.find(current_user.id)
    		render layout: 'user'
	end

	def update
		@user = User.find(params[:id])

	    respond_to do |format|
	      if @user.update_attributes(params[:user])

	        format.html { redirect_to '/user', notice: t('successfully_updated_team') }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @team.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def allowed
		redirect_to :controller=>"user" if current_user
	end

	def login
		render :layout => "application"
	end
	def signup
		render :layout => "application"
	end

	def checkemail
		@email = User.where("email = ?", params[:email])
	    if @email.count > 0
	      if current_user && (current_user.email == params[:email])
	        render :text=>"CRAP", :layout=>false
	      else
	        render :text=>"OK", :layout=>false
	      end
	    else
	      render :text=>"CRAP", :layout=>false
	    end
	end

	   def validate_registration_form(form_data)
	    if params[:post][:password].blank? || params[:post][:email].blank?  || params[:post][:retype_password].blank?   #or params[:post][:user_name] == "" or params[:post][:cid] == "" or params[:post][:state_id] == "" or params[:post][:suburb_id] == ""
	        return false
	    else
	        if validate_email(params[:post][:email])
	          if params[:post][:password] == params[:post][:retype_password]
	            return true
	          else
	            return false
	          end
	        else
	          return false
	        end
	    end    
	  end
   
	   def signout
	    session[:user] = nil
	    #cookies[:token] = nil
	    #cookies[:username] = nil
	    
	    if session[:cart]
	      session[:cart] = {}
	    end
	     if mobile_device?
	      redirect_to '/mobile'
	    else
	      redirect_to '/'
	    end
	  end

	def signin
		if user_exist(params[:email])
	        user = User.where('email = ?', params[:email]).first

              if authenticate(user,params[:password])
                # if session[:cart]
                #     sync_cart_session_and_db(user.user_id, session[:cart].to_json)
                # end
                new_user_session(params[:email])
                render :text=>"OK",:layout=>false
              else
                render :text=>t('email_password_combination_error'),:layout=>false
              end
	      else
	        render :text=>t('user_not_exist'),:layout=>false
	      end
	end
	
	def create
		if self.validate_registration_form(params[:post])

	        #generate activation code
	        # actcode = {
	        #   :email => params[:post][:email],
	        #   :code => generate_activate_code
	        # }
	        # if mobile_device?
	        #   activationcode = 1
	        # else
	        #   activationcode = gen_encrypt(actcode)
	        # end
	        password_encrypt = encrypt(params[:post][:password])

	        user = User.new(
	        		:block => 0, 
	        		:cart => "", 
	        		:email => params[:post][:email], 
	        		:ip => client_ip_address, 
	        		:name => "", 
	        		:newsletter => 1, 
	        		:params => "", 
	        		:password => password_encrypt['password'], 
	        		:salt => password_encrypt['salt'], 
	        		:status => 1, 
	        		:telephone => "", 
	        		:thumbnail => 0, 
	        		:token => "", 
	        		:user_group_id => 1, 
	        		:username => params[:post][:username], 
	        		:wishlist => ""
	        	)
	        begin
	            user.save!
	        rescue Exception => exception
	          logger.debug "An error occurred: #{exception}"
	        end
	        
	        new_user_session(user.email)

	        Site.delay.welcome(user)
	        # case check_username_type(params[:post][:email]).to_i
	        # when 1 #email
	        #   UserMailer.delay(run_at: 10.seconds.from_now).welcome(u)
	        #   #UserMailer.delay(run_at: 10.seconds.from_now).activate(u,activationcode)
	        # when 2 #mobile number
	        # end
	        if mobile_device?
	          redirect_to :controller=>"mobile", :action=>"user"
	        else
	          redirect_to :controller=>"user"
	        end 
	    end
	end

	def upload_thumbnail_image
	end

	def cropthumbnail
		#require 'fileutils'

	    tmp = params[:thumbnail].tempfile
	    ext = File.extname(params[:thumbnail].original_filename)

	    file = File.join(TEMPORARY_FILE_FOLDER, "usr-#{params[:id]}#{ext}".downcase)
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
	      :filename=>"usr-#{params[:id]}#{ext}".downcase, 
	      :dimension=>{
	        :width=>600,
	        :height=>(600/ratio).to_i
	        }}
	 end

	def crop_image
	    if gen_avartar(session[:tmp_thumb_image][:file], 
	        params[:width].to_i,
	        params[:height].to_i,
	        params[:x].to_i,
	        params[:y].to_i,
	        params[:actual_width].to_i,
	        150,
	        "#{USER_FOLDER}#{session[:tmp_thumb_image][:filename]}")

	        session[:tmp_thumb_image] = nil
	        user = User.find(current_user.id)
	        user.thumbnail = 1
	        begin
	          user.save!
	        rescue Exception => exception
	          puts exception.message
	        end
	        render :text=>"OK",:layout=>false
	    else
	        render :text=>"Transfer failed",:layout=>false  
	    end
	  end
end

