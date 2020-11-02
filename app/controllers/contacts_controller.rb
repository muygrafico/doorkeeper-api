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
        puts '--------------'
        puts request.params
        puts '--------------'
        # @page = request.params.page
        @user_id = current_user.id

        email = params[:email]
        page = params[:page]
        per_page = params[:per_page]

        # if (params[:email])
        #   @contacts = Contact.page(page)
        #     .per(params[:per_page])
        #     .where(user_id: @user_id)
        #     .where("email LIKE ?", "%#{email}%")
      # end

        @contacts = Contact.page(page)
          .per(per_page)
          .where(user_id: @user_id)
          .where("email LIKE ?", "%#{email}%")
        # Person.where(:state => "Wisconsin", :single => true)

        # #   render json: {name: 'Carlos', email: 'test'}
        # puts current_user.id
        render json: @contacts
        # render json: { customers: @customers, meta: { total: pageCount, records: Customer.count } }

    end
    private

    def current_user
        @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
    end
  end
  
  