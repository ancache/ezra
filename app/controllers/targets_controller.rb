class TargetsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :create, :edit, :update]

  def index   # GET /targets          -> targets_path
    @targets = Target.paginate(page: params[:page])
  end

  def show    # GET /targets/:id      -> target_path(target) 
    @target = Target.find(params[:id])
    @hits   = @target.hits.where(params.slice(:confirmed, :flagged))
    @features = @target.features
  end

  def new     # GET /targets/new      -> new_target_path
    @target = Target.new
  end

  def create  # POST /targets         -> targets_path
    @target = current_user.targets.build(params[:target])
    if @target.save
      flash[:success] = "Target \"#{@target.phrase}\" created successfully."
      render 'show'
    else
      render 'new'
    end
  end

  def edit    # GET /targets/:id/edit -> edit_target_path(target)
    @target = Target.find(params[:id])
  end

  def update  # PUT /targets/1        -> target_path(target)
    @target = Target.find(params[:id])
    if @target.update_attributes(params[:target], user: @user)
      flash[:success] = "Update successful."
      render 'show'
    else
      render 'edit'
    end
  end

  #def destroy # DELETE /targets/1     -> target_path(target)
  #end
end
