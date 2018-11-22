class SearchsController < ApplicationController
  def index
    @mot = Motel.find(params[:hotel_id])
    flag_1 = false

    if params[:keyword]
      @reviews_all = Review.search(params[:keyword])
    else
      @reviews_all = Review.all?
    end

    @reviews_1 = []
    @reviews_all.each do |r|
      if r.motel_id == @mot.id
        @reviews_1.push(r)
      end
    end

    if params[:sort_order] == "昇順"
      if params[:sort_type] == "評価点"
        @results = @reviews_1.sort_by! { |x| x.rate }
      elsif params[:sort_type] == "ライク数"
        @results = @reviews_1.sort_by! { |x| x.likes.count }
      elsif params[:sort_type] == "投稿日"
        @results = @reviews_1.sort_by! { |x| x.created_at }
      end
    elsif params[:sort_order] == "降順"
      if params[:sort_type] == "評価点"
        @results = @reviews_1.sort_by! { |x| x.rate }.reverse
      elsif params[:sort_type] == "ライク数"
        @results = @reviews_1.sort_by! { |x| x.likes.count }.reverse
      elsif params[:sort_type] == "投稿日"
        @results = @reviews_1.sort_by! { |x| x.created_at }.reverse
      end
    end

    @results = @results.uniq

    respond_to :js

    @results.each do |e|
      puts "review"
      puts e.title
    end
  end

end