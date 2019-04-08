class BlogsController < ApplicationController
    def new
        @blog = Blog.new
    end
    
    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        if params[:back]
            render "new"
        elsif @blog.save
            redirect_to blog_path(@blog.id),notice: "記事を投稿しました！！"
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
        @blog.destroy
        redirect_to blogs_path, notice: "投稿を削除しました！！"
    end
    
    def edit
        @blog = Blog.find(params[:id])
    end
    
    def update
        @blog = Blog.find(params[:id])
        if params[:back]
            @blog.remove_image!
            @blog.save
            render "edit"
        elsif @blog.save
            redirect_to blog_path(@blog.id),notice: "投稿を編集しました！！"
        else
            render "edit"
        end
    end
    
    def confirm
        @blog = Blog.new(blog_params)
    end
    
    private
    
    def blog_params
        params.require(:blog).permit(:title,:content,:image, :image_cache, :remove_image)
    end
    
    
end
