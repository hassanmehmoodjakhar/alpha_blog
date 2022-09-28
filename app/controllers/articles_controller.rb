class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # Action to display the detail of specific Article
  def show
  end

  # Action to display all the articles
  def index
    @articles = Article.all
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
    params.require(:article).permit(:title, :description)
  end
end
