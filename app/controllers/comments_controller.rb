class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.task
    else
      redirect_back fallback_location: tasks_path, flash: {
      comment: comment, 
      error_messages: comment.errors.full_messages
      }
    end
  end 

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.task, flash: { notice: 'コメントが削除されました' }
  end

  private

  def comment_params
    params.require(:comment).permit(:task_id, :name, :comment)
  end 
end
