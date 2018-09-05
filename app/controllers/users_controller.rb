class UsersController < ApplicationController
  filter_resource_access
  def index
    @users = User.all   
  end

  def new
  end

  def create
  end

  def edit
  end

  #def show
  #  @user = User.find(params[:id])
  #end
  
   def show_pdf
      @users = User.all   
        render :pdf => "show_pdf.html.erb",
              :template => "users/show_pdf"
               
      end
    
  def update
    
  end

  def destroy
  end
end

