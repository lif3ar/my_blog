class ArticlesController < ApplicationController
  
  before_action :require_user, except: [:index, :show]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.save
      flash[:success] = "The article has been updated."
      render 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.destroy(params[:id])
    if @article.save
      flash[:danger] = "Article has been deleted"
      redirect_to articles_path
    end
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
