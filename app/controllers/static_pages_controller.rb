class StaticPagesController < ApplicationController

  def home
    if params[:search]
      @motels = Motel.search(params[:search]).page(params[:page])
                    .per Settings.per_page
                    render "static_pages/home"
    else
      @motels = Motel.page(params[:page])
                  .per Settings.per_page
    end
  end
end
