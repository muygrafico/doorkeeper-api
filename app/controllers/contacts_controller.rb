class ContactsController < ApplicationController
    # before_action :authenticate_user!
    before_action :doorkeeper_authorize!
    respond_to    :json
  
    def index
      # Convert the database records to Noticed notification instances so we can use helper methods
        #   @contacts = current_user.contacts
        # @current_user =User.find(session[:user_id])

        # puts '--------------'
        # puts @current_user
        # puts '--------------'
        @user_id = current_user.id
        @contacts = Contact.where(user_id: @user_id)
        # #   render json: {name: 'Carlos', email: 'test'}
        # puts current_user.id
        render json: @contacts
    end
    private

    def current_user
        @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
    end
  end
  
  