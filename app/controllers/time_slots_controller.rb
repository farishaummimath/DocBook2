class TimeSlotsController < ApplicationController
  def index
    @timeslots = TimeSlot.all
  end

  def new
    @title ="Add TimeSlot"
    @timeslot = TimeSlot.new
  end

  def create
    @timeslot = TimeSlot.create(params[:time_slot])

    if @timeslot.save
      flash.now[:success] = "Added TimeSlot"
      redirect_to time_slots_path
    else
      @title = "Add TimeSlot"
      render 'new'
    end
  end

  def edit
     @timeslot = TimeSlot.find(params[:id])
  end

  def update
    @timeslot = TimeSlot.find(params[:id])
    
    if @timeslot.update_attributes(params[:time_slot])
      flash[:success] = "TimeSlot updated."
      redirect_to time_slots_path
    else
      @title = "Edit TimeSlot"
      render 'edit'
    end
  end

  def show
     @timeslot = TimeSlot.find(params[:id])
  end

  def destroy
      @timeslot = TimeSlot.find(params[:id])
      @timeslot.destroy
      redirect_to time_slots_path

  end

end
