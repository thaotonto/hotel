class StaticPagesController < ApplicationController
  def home
    @filterrific = initialize_filterrific(
        Motel,
        params[:filterrific],
        persistence_id: true,
        sanitize_params: true
    ) or return
    @motels = @filterrific.find.page(params[:page]).search(params[:q]).order_level
                  .per(Settings.per_page)

    respond_to do |format|
      format.html
      format.js
    end
  end

end