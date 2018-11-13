class StaticPagesController < ApplicationController
  def home
    if params[:search]
      @motels = Motel.search(params[:search]).page(params[:page])
                    .per Settings.per_page
   elsif params[:search_equipment].blank? && params[:search_room].blank?
      @motels = Motel.search_user(params[:search_name], params[:search_address], params[:search_level]).page(params[:page])
                    .per Settings.per_page
   elsif params[:search_room].blank?
      @motels = Motel.filter_equipment(params[:search_name], params[:search_address], params[:search_level], params[:search_equipment]).page(params[:page])
                    .per Settings.per_page
   elsif params[:search_equipment].blank?
      @motels = Motel.filter_room(params[:search_name], params[:search_address], params[:search_level], params[:search_room]).page(params[:page])
                    .per Settings.per_page
                                    
    elsif params[:search_equipment] || params[:search_room]
      @motels = Motel.filter(params[:search_name], params[:search_address] ,params[:search_level], params[:search_equipment], params[:search_room]).page(params[:page])
                    .per Settings.per_page
    else
      @motels = Motel.page(params[:page])
                  .per Settings.per_page
    end
  end
end
