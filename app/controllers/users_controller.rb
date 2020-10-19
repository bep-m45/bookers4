class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
      @user = current_user
      @users = User.all
      @book = Book.new
  end

  def show
   @user = User.find(params[:id])
   @book = Book.new
   @books = @user.books

  end

  def edit
      @user = User.find(params[:id])
     if @user.id != current_user.id
         redirect_to user_path(current_user.id)
     end
  end

  def create
    @user_image = UserImage.new(user_image_params)
    @user_image.user.id = current_user.id
    @user = User(current_user.id)
    redirect_to @user

     if @user.save
     redirect_to user_path(@user.id)
     else
      redirect_to 'new'
     end
  end

  def update
       @user = User.find(params[:id])
       if @user.update(user_params)
       flash[:noatice] = 'You have updated user successfully.'
       redirect_to user_path(@user.id)
       else
       render 'edit'
       end
  end
  
   def following
    @book = Book.new
    
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'following'
   end

   def followers
    @book = Book.new
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'followers'
   end




  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

