class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # Action to display the detail of specific Article
  def show
    @article = Article.find(params[:id])
  end

  # Action to display all the articles
  def index
    @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  # Action to create a new article and it is get request
  def new
    @article = Article.new
  end

  # Action to edit any article
  def edit
  end

  # Action to create a new article and it is post request
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to @article

    else
      render :new, status: :unprocessable_entity
    end
  end

  # Action to update any article
  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully'
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Action to delete any article
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  # DRY up the code

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit your own article"
    end
  end
end
