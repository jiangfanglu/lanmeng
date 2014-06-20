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
end
