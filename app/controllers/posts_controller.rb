class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :destroy, :update]
  # :new :create :delete
  before_action :authenticate_user!, except: [:show, :index] # :new :create :delete

  # GET /posts
  # GET /posts.json
  def index
    @posts = if params[:my].present?
      Post.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
    elsif params[:tag].present?
      Post.tagged_with(params[:tag])
    else
      Post.all.paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.date = Time.now
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      attrs = post_params
      #attrs[:tag_list] = attrs[:tag_list].slice(',')
      if @post.update(attrs)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    notice = ''
    if @post.user == current_user
      @post.destroy
      notice = 'Post was successfully destroyed.'
    else
      notice = 'You don\'t have permissions to delete this post. You aren\'t the owner' 
    end

    respond_to do |format|
      format.html { redirect_to posts_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :date, :user_id, :tag_list)
    end

end
