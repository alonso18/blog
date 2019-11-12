class ArticlesController < ApplicationController
    before_action :find_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :update, :destroy]
    def index
        @articles = Article.all
    end

    def from_user
        @user = User.find(params[:user_id])
    end

    def show
    end

    def edit
        
        # <%= form.text_field :category_elements%>
        @categories = Category.all
    end

    def update
        @article.update(article_params)
        @article.save_categories
        redirect_to @article
    end

    def destroy
        @article.destroy

        redirect_to root_path
    end

    def new
        @categories = Category.all
        @article = Article.new
    end

    def create
        @article = current_user.articles.create(article_params)
        @article.save_categories
        render @article
    end

    def find_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :content, category_elements: [])
    end
end
