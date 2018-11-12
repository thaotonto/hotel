class StaticPagesController < ApplicationController

  def home
    if params[:search_equipment].blank? && params[:order_price].blank?
      @motels = Motel.search_name_level(params[:search_name], params[:search_level]).page(params[:page])
                    .per Settings.per_page
    elsif params[:search_name] || params[:search_level] || params[:search_equipment] || params[:order_price]
      @motels = Motel.filter(params[:search_name], params[:search_level], params[:search_equipment], params[:order_price]).page(params[:page])
                    .per Settings.per_page
    else
      @motels = Motel.page(params[:page])
                  .per Settings.per_page
    end
  end
end
