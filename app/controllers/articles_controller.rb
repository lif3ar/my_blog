class ArticlesController < ApplicationController
  
  before_action :require_user, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
    if !logged_in?
      flash[:danger] = "You must log in to add an article"
      redirect_to root_path
    end
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
  end

  def edit
  end

  def update
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
    
    def set_article
      @article = Article.find(params[:id])
    end
    
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only perform that action to your own articles"
        redirect_to articles_path
      end
    end
    
end
