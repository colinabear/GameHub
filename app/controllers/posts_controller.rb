class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	helper_method :sort_direction

	def index
		if params[:search]
				@posts = Post.where('title LIKE ? OR content LIKE ? OR author LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page params[:page]
  			if params[:sort] == 'updated_at'
		      @posts = @posts.order("updated_at DESC")
		    elsif params[:sort] == 'created_at'
		      @posts = @posts.order("created_at DESC")
				elsif params[:sort] == 'name'
					@posts = @posts.order("title ASC")
				elsif params[:sort] == 'name_reverse'
					@posts = @posts.order("title DESC")
				elsif params[:sort] == 'popularity'
					@posts = @posts.order(cached_votes_score: :desc)
				else
					@posts = @posts
				end
		else
				@posts = Post.page params[:page]
				if params[:sort] == 'updated_at'
					@posts = @posts.all.order("updated_at DESC")
				elsif params[:sort] == 'created_at'
					@posts = @posts.all.order("created_at DESC")
				elsif params[:sort] == 'name'
					@posts = @posts.all.order("title ASC")
				elsif params[:sort] == 'name_reverse'
					@posts = @posts.all.order("title DESC")
				elsif params[:sort] == 'popularity'
					@posts = @posts.all.order(cached_votes_score: :desc)
				else
					@posts = @posts.all.order("created_at DESC")
				end
		end
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.author = current_user.email

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.comments.each do |comment|
			comment.destroy
		end
		@post.destroy
		redirect_to post_index_path
	end

	def upvote
		@post = Post.find(params[:id])
		@post.upvote_by current_user
		redirect_to post_index_path
	end

	def downvote
		@post = Post.find(params[:id])
		@post.downvote_by current_user
		redirect_to post_index_path
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content, :author, :search)
	end

end
