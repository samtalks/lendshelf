class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join_group, :leave_group, :approve_member, :deny_member]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @available_group_items = []
    @unavailable_group_items = []
    @group.users.includes(:items).each do |user|
      if user != current_user && user.group_membership(@group).state != "pending"
        @available_group_items = @available_group_items + user.items.where(:state => "available")
        @unavailable_group_items = @unavailable_group_items +  user.items.where.not(:state => "available")
      end 
    end
    @members = @group.memberships.where.not(:state => "pending")
    @pending = @group.memberships.where(:state => "pending")
  end


  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  def join_group
    @group.memberships.create(:user_id => params[:user_id])
    redirect_to @group, notice: "Your membership request has been submitted"
  end

  def leave_group
    membership = @group.memberships.find_by(:user_id => params[:user_id])
    membership.destroy
    if @group.memberships.size == 0
      @group.destroy
      redirect_to current_user, notice: "You were the last member of that group. It is now gone :( "
    else
      redirect_to @group
    end
  end

  def approve_member
    membership = @group.memberships.find_by(:user_id => params[:user_id])
    membership.approve_member
    redirect_to @group
  end

  def deny_member
    membership = @group.memberships.find_by(:user_id => params[:user_id])
    membership.destroy
    redirect_to @group
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        @group.memberships.create(user_id: current_user.id, state: "owner")
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
