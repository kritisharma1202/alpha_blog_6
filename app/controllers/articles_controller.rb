class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    #temporarily hardcode to assign user to article bcoz for now we dont have authentication sys
    #@article.user = User.first
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article is saved successfully...!!!"
      #render plain: @article.inspect
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article is Updated Successfully...!!!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article is Deleted Successfully...!!!"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    #params.fetch(:article, {}).permit(:title, :description)
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only Edit or Delete your own article"
      redirect_to @article
    end
  end

end
