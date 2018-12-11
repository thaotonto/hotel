class MotelsController < ApplicationController
  load_and_authorize_resource
  before_action :find_motel, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @motels = Motel.order_level.search(params[:search]).page(params[:page]).per 5
    else
      @motels = Motel.order_level.page(params[:page]).per 5
    end
  end

  def new
    @motel = Motel.new
  end

  def create
    @motel = Motel.new motel_params
    if @motel.save
      redirect_to motel_path(@motel)
    else
      render :new
    end
  end

  def show
    @hash = Gmaps4rails.build_markers(@motel) do |motel, marker|
      marker.lat motel.latitude
      marker.lng motel.longitude
      marker.infowindow motel.name
    end

    @ke = KeyphraseExtraction.new()
    @reviews = @motel.reviews.page(params[:page]).per 15
    @reviews_text = @motel.reviews.pluck(:content)
    review_rating = @motel.reviews.pluck(:rate)
    @ratecount_5 = review_rating.count {|x| x == 5}
    @ratecount_4 = review_rating.count {|x| x == 4}
    @ratecount_3 = review_rating.count {|x| x == 3}
    @ratecount_2 = review_rating.count {|x| x == 2}
    @ratecount_1 = review_rating.count {|x| x == 1}
    @max_num = [@ratecount_5, @ratecount_4, @ratecount_3, @ratecount_2, @ratecount_1].max
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @motel.update_attributes motel_params
      flash[:success] = t "flash.update_success"
      redirect_to motel_path(@motel)
    else
      render :edit
    end
  end

  def destroy
    if @motel.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to root_path
    else
      flash[:danger] = t "flash.delete_fail"
      redirect_to root_path
    end
  end

  def load_more
    @review = Review.find_by id: params[:review_id]
    render 'motels/load_more'
  end

  def search
    @motels = Motel.ransack(name_cont: params[:q], address_cont: params[:q], zone_cont: params[:q], genre_cont: params[:q], m: "or").result(distinct: true)
    respond_to do |format|
      format.html {}
      format.json {
        @motels = @motels.limit(5)
      }
    end
  end

  def  add_bookmark
      @motel = Motel.find_by id: params[:motel_id]
      UserHotel.create user_id: current_user.id , motel_id: @motel.id
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js { render 'motels/bookmark.js.erb' }
      end
    end
  def  undo_bookmark
    @motel = Motel.find_by id: params[:motel_id]
    UserHotel.where(user_id: current_user.id, motel_id: @motel.id).delete_all
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js { render 'motels/bookmark.js.erb' }
    end
  end


  private

  def motel_params
    params.require(:motel).permit :name, :description, :address, :phone, :level, :zone, {images: []},
                                  hotel_equips_attributes: [:id, :_destroy, :price, :equipment_id],
                                  hotel_rooms_attributes: [:id, :_destroy, :price, :room_id]
  end

  def find_motel
    @motel = Motel.find_by id: params[:id]

    return if @motel
    flash[:danger] = t "flash.no_record"
    redirect_to root_url
  end
end