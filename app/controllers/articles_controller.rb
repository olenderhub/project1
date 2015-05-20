class ArticlesController < ApplicationController

  before_action :authenticate_user!

  def index
    @articles = Article.all.includes(:user)
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @article }
      format.xml { render xml: @article }
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    if session[:article_id] != @article.id
      flash[:notice] = "Nie możesz tego edytować"
      redirect_to(articles_path)
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    # @article[:user_id] = current_user.id
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    authorize! :update, @article
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :photo)
    end
end
