class StaticPagesController < ApplicationController

  def home
    if params[:search]
      @motels = Motel.search(params[:search]).page(params[:page])
                    .per Settings.per_page
    elsif params[:search_name] || params[:search_level]
      @motels = Motel.filter(params[:search_name], params[:search_level]).page(params[:page])
                    .per Settings.per_page
    else
      @motels = Motel.page(params[:page])
                  .per Settings.per_page
    end
  end
end
