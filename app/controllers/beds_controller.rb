class BedsController < ApplicationController
  filter_resource_access
  def index
    @beds= Bed.all
  end

  def new
        @title = "Add Bed"
        @bed= Bed.new
        
  end

  def create
    @bed = Bed.create(params[:bed])
    if @bed.save
      flash[:success] = "Bed created."
      redirect_to beds_path
    else
      render :action => 'new'
    end
  end
  
  def show
    @bed = Bed.find(params[:id])
 
  end

  def edit
    @bed = Bed.find(params[:id])
  end

  def update
     @bed = Bed.find(params[:id])
    if @bed.update_attributes(params[:bed])
      flash[:success] = "Bed updated."
      redirect_to beds_path
    else
      @title = "Edit Bed"
      render 'edit'
    end
  end

  def destroy
     @bed = Bed.find(params[:id])
     @bed.destroy
     redirect_to beds_path
  end


end
