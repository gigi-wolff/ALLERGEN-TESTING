class SearchesController < ApplicationController
  before_action :set_search_item, :set_user
  before_action :authenticate_user!

# The purpose of the controller is to manage the incoming request and session

  def search
    # calls search.html.erb by default   
  end

  private
  def set_search_item
    @search_item = params[:search].upcase
  end

  def set_user
    @user_id = current_user.id
  end

end