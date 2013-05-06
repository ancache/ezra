class FeaturesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_user, only: [:new, :create, :edit, :update]

  def index   # GET /features          -> features_path
    @features = Feature.paginate(page: params[:page])
  end

  def show    # GET /features/:id      -> feature_path(feature)
    @feature = Feature.find(params[:id])
  end

  def new     # GET /features/new      -> new_feature_path
    @feature = Feature.new
  end

  def create  # POST /features         -> features_path
    @feature = current_user.features.build(params[:feature])
    if @feature.save
      flash[:success] = "Feature \"#{@feature.name}\" created successfully."
      render 'show'
    else
      render 'new'
    end
  end


  def edit    # GET /features/:id/edit -> edit_feature_path(feature)
    @feature = Feature.find(params[:id])
  end

  def update  # PUT /features/1        -> feature_path(feature)
    @feature = Feature.find(params[:id])
    if params[:commit] === 'Cancel'
      flash[:success] = "No updates"
    elsif @feature.update_attributes(params[:feature], user: @user)
      flash[:success] = "Update successful."
    else
      render 'edit'
    end
    redirect_to :action=>'index'
  end


  # def destroy # DELETE /features/1     -> feature_path(feature)
  # end

end
