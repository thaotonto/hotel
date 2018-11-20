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

    # if params[:review_type] == "ポジティブ"
    #   type = 1
    # elsif params[:review_type] == "ニュートラル"
    #   type = 0
    # elsif params[:review_type] == "ネガティブ"
    #   type = -1
    # else
    #   type = nil
    # end
    #
    #
    # @reviews = Motel.find(params[:hotel_id]).reviews
    # @reviews_2 = []
    # if type == -1
    #   @reviews.each do |review|
    #     if review.rate.to_i <= 3 && review.rate.to_i >= 0
    #       @reviews_2.push(review)
    #     end
    #   end
    # elsif type == 1
    #   @reviews.each do |review|
    #     if review.rate.to_i <= 5 && review.rate.to_i >= 4
    #       @reviews_2.push(review)
    #     end
    #   end
    # elsif type == 0
    #   @reviews.each do |review|
    #     if review.rate.to_i < 4 && review.rate.to_i > 3
    #       @reviews_2.push(review)
    #     end
    #   end
    # else
    #   @reviews.each do |review|
    #     @reviews_2.push(review)
    #   end
    # end
    #
    # if params[:keyword] != ""
    #   flag_1 = true
    # end
    #
    # @results = []
    #
    # if flag_1 == true # have search keyword
    #   @reviews_1.each do |review|
    #     if type == 1
    #       if review.rate.to_i <= 5 && review.rate.to_i >= 4
    #         @results.push(review)
    #       end
    #     elsif type == -1
    #       if review.rate.to_i <= 3 && review.rate.to_i >= 0
    #         @results.push(review)
    #       end
    #     elsif type == 0
    #       if review.rate.to_i < 4 && review.rate.to_i > 3
    #         @results.push(review)
    #       end
    #     else
    #       @results.push(review)
    #     end
    #   end
    # else # don't have search keyword
    #   @reviews_2.each do |review|
    #     @results.push(review)
    #   end
    # end

    @results = @results.uniq

    respond_to :js

    @results.each do |e|
      puts "review"
      puts e.title
    end
  end

end