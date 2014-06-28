class Site < ActionMailer::Base
  default from: "info@wanlanqiu.com"
  layout 'mail'
  def welcome user
    @user = user
    mail(to: @user.email, subject: t("welcome_to_wanlanqiu"))
  end

  def court_request information
  	@information = information
  	mail(to: "info@wanlanqiu.com", subject: t("new_court_provided"))
  end

  def inivte_friends invitor, friend_qq, team_id
  	@invitor = invitor
  	@team_id = team_id
  	mail(to: "#{friend_qq}@qq.com", subject: "#{invitor}#{t('join_his_team')}")
  end

  def reset_pwd email, code
    @code = code
    @email = email
    mail(to: email, subject: t('password_reset_title'))
  end
end
