class CommentsController < ApplicationController
  before_action :find_comment, except: [:create, :index]
  before_action :find_review

  def index
    @comments = @review.comments.order_comment.limit(params[:limit])
    respond_to do |format|
        format.js {render "comments/create"}
    end
  end

  def create
    @comment = Comment.new comment_params
    @comments = @review.comments.order_comment.limit(params[:limit])
    if @comment.save
      respond_to do |format|
        format.js {render "comments/create"}
      end
    else
      respond_to do |format|
        format.js { render "comments/error"}
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_update_params
      @comments = @review.comments.order_comment.limit(params[:limit])
      respond_to do |format|
        format.js {render "comments/create"}
      end
    else
      respond_to do |format|
        format.js { render "comments/error"}
      end
    end
  end

  def destroy
    @comments = @review.comments.order_comment.limit(params[:limit])
    if @comment.destroy
      respond_to do |format|
        format.js {render "comments/create"}
      end
    else
      respond_to do |format|
        format.js { render "comments/error"}
      end
    end
  end

  private

  def find_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment
    respond_to do |format|
      format.js { render "comments/error"}
    end
  end

  def find_review
    @review = Review.find_by id: params[:review_id]

    return if @review
    respond_to do |format|
      format.js { render "comments/error" }
    end
  end

  def comment_params
    params.permit :content, :user_id, :review_id
  end

  def comment_update_params
    params.require(:comment).permit :content, :user_id, :review_id
  end
end
