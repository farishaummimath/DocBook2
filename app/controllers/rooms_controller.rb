class RoomsController < ApplicationController
  filter_access_to :all
  def index
    @rooms= Room.all
    @beds= Bed.all
  end

  def new
        @title = "Add Room"
        @room= Room.new
  end
  def room_dashboard
    
  end
  def create
    @room = Room.new(params[:room])
    if @room.save
      flash[:success] = "Room created."
      redirect_to rooms_path
    else
      render :action => 'new'
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @beds = @room.beds
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
     @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      flash[:success] = "Room updated."
      redirect_to rooms_path
    else
      @title = "Edit Room"
      render 'edit'
    end
  end
  
  def all_rooms
    @beds = Room.find_beds 
       
  end
  
  def export
    @beds = Room.find_beds
    beds_csv = FasterCSV.generate do |csv|
    # header row
    csv << ["Room Number","Total Beds", "Occupied Beds in %", "Available Beds in %"]

    # data rows
    @beds.each do |bed|
      csv << [bed.room_number,bed.total_beds,bed.occupied_beds,bed.available_beds]
    end
  end
   
  send_data(beds_csv, :type => 'text/csv', :filename => 'rooms.csv')
  end

  def destroy
     @room = Room.find(params[:id])
     @room.destroy
     redirect_to rooms_path
  end


end
