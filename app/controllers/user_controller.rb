class UserController < ApplicationController
	include ApplicationHelper
	#layout 'user'
	before_filter :allowed, :only => [:login, :signup]
	def index

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
end
