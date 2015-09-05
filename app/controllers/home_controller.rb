class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to accounts_path
    # else
      # render :file => "/path/to/some/404_template", :status => 404
    end
  end

  def faq
  end

end
