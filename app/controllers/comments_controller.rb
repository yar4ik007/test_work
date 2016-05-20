class CommentsController < ApplicationController
	before_action :set_post_and_comment, only: [:edit, :update]

	def create
    	@post = Post.find(params[:post_id])
    	@comment = @post.comments.create(comment_params)
    	redirect_to post_path(@post)
  	end
  	
  	def edit
  	end

  	def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  	end


  	private
  	def set_post_and_comment
    	@post = Post.find(params[:post_id])
  		@comment = Comment.find(params[:id])
  	end

  	def comment_params
      params.require(:comment).permit(:user_id, :body)
    end
end
