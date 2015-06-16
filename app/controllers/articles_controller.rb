class ArticlesController < ApplicationController

  before_action :authenticate_user!

  def index
    @articles = Article.includes(:user)
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
    if @article.user != current_user
      flash[:warning] = "You can't edit this!"
      redirect_to(articles_path)
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
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
    authorize! :destroy, @article
    @article.destroy
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :photo)
    end
end
