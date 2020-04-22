class ApplicationController < ActionController::Base
    layout 'application'
    before_action :set_constants

    def set_constants
        @user = session[:logged_in_user]
    end

end
