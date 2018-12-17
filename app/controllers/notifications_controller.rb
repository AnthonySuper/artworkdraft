class NotificationsController < ApplicationController
  before_action :load_notification, only: [:show, :update, :destroy]

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification }
        format.json { render 'show' }
      else
        format.html do
          flash[:warning] = "Notification not updated"
          redirect_back(fallback: root_path)
        end
        format.json do
          render @notification.errors, status: :unprocessable_entity
        end
      end
    end
  end

  protected

  def notification_params
    params.require(:notification).permit(:read)
  end

  def load_notification
    @notification = Notification.find(params[:id])
    authorize @notification
  end

end
