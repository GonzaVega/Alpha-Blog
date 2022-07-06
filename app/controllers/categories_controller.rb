class CategoriesController < ApplicationController
before_action :require_admin, except: [:index, :show, :search]
    def new
        @category = Category.new
    end
    def search
        if params[:search].blank?
            flash[:alert] = "Please enter a search first"
            redirect_to categories_path and return
        else
            @parameter = params[:search].downcase
            @results = Category.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
        end
    end
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    def create
        @category = Category.new(category_params)
        if @category.save
        flash[:notice] = "Category was successfully created"
        redirect_to @category
        else
            render 'new'
        end
    end
    def show
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 5) 
    end
    def edit
        @category = Category.find(params[:id])
    end
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:notice] = "Category was successfully update"
            redirect_to @category
        else
            render 'edit'
        end
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
    def require_admin
       if  !(logged_in? && current_user.admin?)
        flash[:alert] = "Only admins can perform that action"
        redirect_to categories_path
        end
    end
end