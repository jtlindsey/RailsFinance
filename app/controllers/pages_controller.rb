class PagesController < ApplicationController
  def index

    # want to call partials by click
    # is this better than just making manual pages???
    # http://stackoverflow.com/questions/3421980/ruby-on-rails-simple-page-without-database-model
    # filter the params[:id] here to allow only certain values like
    # if params[:id].match /browse|help/
      # render :partial => params[:id]
    # else
      # render :file => "/path/to/some/404_template", :status => 404
    # end
  end
end
