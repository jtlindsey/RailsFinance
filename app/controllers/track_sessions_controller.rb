class TrackSessionsController < Devise::SessionsController
  after_filter :after_login, :only => :create

  def after_login
    Visit.create!(user_id: current_user.id, user_ip: current_user.current_sign_in_ip, user_email: current_user.email)
  end
end


# User.all.each do |user|
#   logins_per_day(user.id) 
# end

# def logins_per_day(user_id)
#   dates_visited = Visit.where(user_id: user_id).select('distinct created_at').all.collect{|x| x[:created_at].to_date}
#   puts "************* USER ID #{user_id} *************"
#   dates_visited.group_by {|date| date}.map {|date_visited, times_visited| puts "Date Visited: #{date_visited} Times Visited: #{times_visited.count}"}
# end
