class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def create
        # create a new user; save their hashed password in the database; save the user's ID in the session hash; and return the user object in the JSON response.
    user = User.create(user_params)
    if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
    else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
end
    def show
        # If the user is authenticated, return the user object in the JSON response.
        user = User.find_by(id: session[:user_id])
        render json: user 
        end
    end
    private 

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
      end
      
    def user_params
        params.permit(:username, :password, :password_confirmation)
end
