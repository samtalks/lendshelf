class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :approve_loan, :request_loan, :deny_loan, :return_loan]
  before_action :set_item, only: [:approve_loan, :request_loan, :deny_loan, :return_loan]
  skip_before_filter :authenticate_user!, only: [:index, :splash]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def request_loan
    @user.request_loan(@item)
    redirect_to(@user)
  end

  def approve_loan
    @user.approve_loan(@item)
    redirect_to(@user)    
  end

  def deny_loan
    @user.deny_loan(@item)
    redirect_to(@user)
  end

  def return_loan
    @user.return_loan(@item)
    redirect_to(@user)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def splash
    if current_user
      redirect_to current_user
    else
      render :layout => false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
