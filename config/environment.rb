# Load the rails application
require File.expand_path('../application', __FILE__)

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
VALID_MOBILE_REGEX = /^[1][358]\d{9}$/
BUCKET_NAME = "lanmeng"
ALIYUNOSS_ACCESS_KEY_ID = "tZu94MC4MJVTEuvj"
ALIYUNOSS_SECRET_ACCESS_KEY = "e8iglZEc1rKeIv3KbepxnvftGoY7Q7"

# Initialize the rails application
Lanmeng::Application.initialize!
