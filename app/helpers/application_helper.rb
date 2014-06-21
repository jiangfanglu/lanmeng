module ApplicationHelper
	def set_user_city city_id
		cookies[:user_city] = {value: city_id, expires: 20.years.from_now.utc}
	end

	def current_city
		cookies[:user_city]
	end

	def current_city_name
		City.find(cookies[:user_city]).name
	end

	def set_user_tournament tournament_id
		cookies[:user_tournament] = {value: tournament_id, expires: 20.years.from_now.utc}
	end

	def current_tournament
		cookies[:user_tournament]
	end

	def new_user_session(email)
	      user = User.where('email = ?', email).first
	      session[:user] = {
	        :id => user.id,
	        :name => user.name,
	        :email => user.email,
	        :thumbnail => user.thumbnail
	      }
	      user.save # 如果没有token将创建
        set_current_user user
	      #cookies[:username] = {value: user.username, expires: 20.years.from_now.utc}
	      #cookies[:token] = {value: user.token, expires: 20.years.from_now.utc}
	end

	  def gen_encrypt(obj)
	  	return Base64.encode64(Marshal.dump(obj)).gsub(/\n/,'')
	  end
	  def gen_decrypt(string)
	  	return Marshal.load(Base64.decode64(string))
	  end

	  def val_user
	  	if !current_user
	  		redirect_to "/mobile/shop"
	  	end
	  end

	  def match_password(password,retype_password)
	    if password != retype_password
	      return false
	    else
	      return true
	    end
	  end
	  def client_ip_address
	    ip = request.remote_ip.to_s
	    if ip == '127.0.0.1'
	      return request.env["HTTP_X_FORWARDED_FOR"].to_s
	    else
	      return ip
	    end
	  end
	  def encrypt(submitted_password)
	    salt = SecureRandom.base64(8)
	    hashed_password = Digest::SHA2.hexdigest(salt + submitted_password)
	    return {"salt"=>salt,"password"=>hashed_password}
	  end

	  def authenticate(user,password_to_confirm)
	    return user.password.to_s == Digest::SHA2.hexdigest(user.salt + password_to_confirm).to_s
	  end

	  def user_exist(email)
	    user_count = User.where('email = ?', email).count
	    return true if user_count > 0

	  end

	  def get_user_salt(email)
	    user = User.where("email = ?", "#{email}").first
	    return user.salt
	  end

	  def set_page_params
	      params[:page] ||= 1
	  end

	  def mobile_device?
		  if session[:mobile_param]
		    session[:mobile_param] == "1"
		  else
		    !(request.user_agent =~ /Mobile|webOS|Mobi|mobile|micromessenger|UCBrowser/).blank? && (request.user_agent =~ /iPad/).blank?
		  end
		end

	  def current_user
	      session[:user] = {} if session[:user].blank?
	      @current_user ||= User.where(id: session[:user]['id']).first || false
	    end

	    def set_current_user user
	      @current_user = user
	      session[:user]['id'] = user.id
	    end

	  def generate_activate_code
	  	code = ""
	  	n=0
	  	while n<6
	  		code += rand(9).to_s
	  		n += 1
	  	end
	  	return code
	  end

	  def remove_html_tags(str)
	  	return CGI.unescapeHTML(str.gsub(/<\/?[^>]+>/, '').gsub('&amp;', '&')).gsub("\n","")
	  end

	  def check_username_type(input)
	  	username_type = 0
	  	if validate_email(input)
	  		username_type = 1
	  	end
	  	if validate_phone_number(input)
	  		username_type = 2
	  	end
	  	return username_type
	  end

	  def validate_email(input)
	      if VALID_EMAIL_REGEX.match(input) != nil
	        return true
	      else
	        return false
	      end
	  end

	  def validate_phone_number(input)
	  	 if VALID_MOBILE_REGEX.match(input) != nil
	        return true
	      else
	        return false
	      end
	  end

	  def upload_image_basic(f, filename, foldername)
	    tmp = f.tempfile
	    ext = File.extname(f.original_filename)

	    basic_file_name = "#{filename}#{ext}".downcase

	    #image = MiniMagick::Image.open(tmp.path)

	    # PUT files to Aliyun OSS code here start
	    	store_aliyunoss_fail = false
    		begin
	      response = Aliyun::OSS::OSSObject.store(
	        "#{foldername}#{basic_file_name}",
	        open(tmp.path),
	        BUCKET_NAME)
	    rescue Aliyun::OSS::ResponseError => error
	      puts "#{error.code}:#{error.message}"
	    end

	    if not response.success?
	      store_aliyunoss_fail = true
	    end
	    # Aliyun OSS code finish

	    return store_aliyunoss_fail, basic_file_name
	  end
end
