class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def date_part_to_date(year, month, date)
    [year, month, date].join("/")
  end
end
