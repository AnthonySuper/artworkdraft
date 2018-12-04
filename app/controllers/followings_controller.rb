class FollowingsController < ApplicationController
  def create
    @following = Following.new(following_params)
    authorize @following
    respond_to do |format|
      if @following.save
        format.html { 
          redirect_back(fallback_location: users_path(@following.followee))
        }
        format.json { render @following }
      else
        format.html { 
          redirect_back(fallback_location: users_path(@following.followee))
        }
        format.json { render @following.errors, status: 401 }
      end
    end
  end

  def destroy
    @following = Following.where(follower_id: current_user,
                                 followee_id: params[:id]).first
    authorize @following
    @following.destroy
    respond_to do |format|
      format.json
      format.html {
        redirect_back(fallback_location: users_path(@following.followee))
      }
    end
  end

  def following_params
    params.require(:following)
      .permit(:followee_id)
      .merge(follower: current_user)
  end
end
