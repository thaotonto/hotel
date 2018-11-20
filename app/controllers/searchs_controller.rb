class SearchsController < ApplicationController
  def index
    @mot = Motel.find(params[:hotel_id])
    flag_1 = false
    @reviews_1 = Review.search(params[:keyword])

    if params[:review_type] == "ポジティブ"
      type = 1
    elsif params[:review_type] == "ニュートラル"
      type = 0
    elsif params[:review_type] == "ネガティブ"
      type = -1
    else
      type = nil
    end

    puts "type"
    puts type


    @reviews = Motel.find(params[:hotel_id]).reviews
    @reviews_2 = []
    if type == -1
      @reviews.each do |review|
        if review.rate.to_i <= 3 && review.rate.to_i >= 0
          @reviews_2.push(review)
        end
      end
    elsif type == 1
      @reviews.each do |review|
        if review.rate.to_i <= 5 && review.rate.to_i >= 4
          @reviews_2.push(review)
        end
      end
    elsif type == 0
      @reviews.each do |review|
        if review.rate.to_i < 4 && review.rate.to_i > 3
          @reviews_2.push(review)
        end
      end
    else
      @reviews.each do |review|
        @reviews_2.push(review)
      end
    end

    if params[:keyword] != ""
      flag_1 = true
    end

    @results = []

    if flag_1 == true       # have search keyword
      @reviews_1.each do |review|
        if type == 1
          if review.rate.to_i <= 5 && review.rate.to_i >= 4
            @results.push(review)
          end
        elsif type == -1
          if review.rate.to_i <= 3 && review.rate.to_i >= 0
            @results.push(review)
          end
        elsif type == 0
          if review.rate.to_i < 4 && review.rate.to_i > 3
            @results.push(review)
          end
        end
      end
    else      # don't have search keyword
      @reviews_2.each do |review|
        @results.push(review)
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