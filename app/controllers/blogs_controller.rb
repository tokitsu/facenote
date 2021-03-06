class BlogsController < ApplicationController
  def new
    @current_user == current_user
    if @current_user == nil
      redirect_to new_user_path
    elsif 
      @blog = Blog.new
    end
  end
    
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @current_user == current_user
    if @current_user == nil
      redirect_to new_user_path
    elsif @blog.user != current_user
      redirect_to new_user_path
    elsif  params[:back]
      render "new"
    elsif 
      @blog.save
      redirect_to blogs_path(@blog.id),notice: "記事を投稿しました！！"
    else
      render "new"
    end
  end
    
  def index
    @blogs = Blog.all
  end
    
  def show
    @blog = Blog.find(params[:id])
  end
    
  def destroy
    @blog = Blog.find(params[:id])
    if @blog.user != current_user
      redirect_to new_session_path
    else
    @blog.destroy
    redirect_to blogs_path, notice: "投稿を削除しました！！"
    end
  end
    
  def edit
    @blog = Blog.find(params[:id])
  end
    
  def update
    @blog = Blog.find(params[:id])
    @current_user == current_user
    if current_user == nil
      redirect_to new_user_path
    elsif @blog.user != current_user
      redirect_to blogs_path
    elsif params[:back]
      @blog.remove_image!
      @blog.update(blog_params)
      render "edit"
    elsif
      @blog.update(blog_params)
      redirect_to blog_path(@blog.id),notice: "投稿を編集しました！！"
    end
  end
    
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    render "new" if @blog.invalid?
  end
    
  private
    
  def blog_params
    params.require(:blog).permit(:title,:content,:image, :image_cache, :remove_image)
  end
end
