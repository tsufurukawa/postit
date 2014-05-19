class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "You successfully created a new category."
      redirect_to root_path
    else
      render :new
    end 
  end

  def show
    @category = Category.find(params[:id])
  end
end