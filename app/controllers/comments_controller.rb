class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.user != current_user
      flash[:notice] = "Nie możesz tego usunąć"
      redirect_to(@article)
    else
      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
