class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authenticate_user,{only: [:update, :destroy, :show, :index]}
  
  def authenticate_user
    @current_user == current_user
    if @current_user == nil
      redirect_to new_user_path
    else
    end
  end
end
