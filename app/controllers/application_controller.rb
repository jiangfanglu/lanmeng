class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :aliyunoss_authenticate
  include ApplicationHelper
  def aliyunoss_authenticate
    Aliyun::OSS::Base.establish_connection!(
       :access_key_id     => ALIYUNOSS_ACCESS_KEY_ID, 
       :secret_access_key => ALIYUNOSS_SECRET_ACCESS_KEY
    )
  end
end
