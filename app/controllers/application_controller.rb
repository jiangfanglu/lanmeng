class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :aliyunoss_authenticate, :init_app
  include SimpleCaptcha::ControllerHelpers
  include ApplicationHelper
  def aliyunoss_authenticate
    Aliyun::OSS::Base.establish_connection!(
       :access_key_id     => ALIYUNOSS_ACCESS_KEY_ID, 
       :secret_access_key => ALIYUNOSS_SECRET_ACCESS_KEY
    )
  end

  def init_app
    if current_user
      if current_user.is_player?
        if current_user.player.owns_team?
          @team_requests = join_team_requests_number
        else
          @team_requests = 0
        end
      else
        @team_requests = 0
      end
    end
  else
    @team_requests = 0
  end
end
