class RepliesController < ApplicationController
  before_action :find_comment
  before_action :find_reply, except: [:index, :create]

  def index
    @replies = @comment.feedbacks.limit(params[:limit])
    respond_to do |format|
        format.js {render "replies/index"}
    end
  end

  def create
    @reply = Replie.new reply_params
    @replies = @comment.feedbacks.limit(params[:limit])
    if @reply.save
      respond_to do |format|
        format.js {render "replies/index"}
      end
    else
      respond_to do |format|
        format.js { render "replies/error"}
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
    if @reply.update_attributes reply_update_params
    @replies = @comment.feedbacks.limit(params[:limit])
      respond_to do |format|
        format.js {render "replies/index"}
      end
    else
      respond_to do |format|
        format.js { render "replies/error"}
      end
    end
  end

  def destroy
    @replies = @comment.feedbacks.limit(params[:limit])
    if @reply.destroy
      respond_to do |format|
        format.js {render "replies/index"}
      end
    else
      respond_to do |format|
        format.js { render "replies/error"}
      end
    end
  end

  private

  def find_reply
    @reply = Replie.find_by id: params[:id]

    return if @reply
    respond_to do |format|
      format.js { render "replies/error"}
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:comment_id]

    return if @comment
    respond_to do |format|
      format.js { render "replies/error" }
    end
  end

  def reply_params
    params.permit :content, :user_id, :comment_id
  end

  def reply_update_params
    params.require(:replie).permit :content, :user_id, :comment_id
  end
end
