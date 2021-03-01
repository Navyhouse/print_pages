class UsersController < ApplicationController

    def show
       @user = User.find(params[:id])
   end

    def edit
       @user = User.find(params[:id])
    end 

    def update
       @user = User.find(params[:id])
       if @user.update(user_params)
         flash[:notice] = "成功！"
         redirect_to("/users/#{@user.id}")
       else
         flash.now[:alert] = "失敗！"
         render("users/edit")
       end
    end

  private
    def user_params
       params.require(:user).permit(:name, :email)
    end


end
