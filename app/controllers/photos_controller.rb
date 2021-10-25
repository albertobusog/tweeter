class PhotosController < ApplicationController
    def index
        @user = user
        @photo = @user.photo
    end

    def show
        @photo = user.photo
        if @photo
        else
            render json: { error: 'The user does not have photo' }
        end
    end

    def create
        @photo = user.photo.create(url: params) 
          
    end

    private
    def user
        User.find(params[:user_id])
    end


end
