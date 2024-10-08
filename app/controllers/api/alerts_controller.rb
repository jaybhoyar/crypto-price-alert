class Api::AlertsController < ApplicationController

  def index
    status = params[:status].presence_in(Alert::STATUSES) || 'created'
    page = params[:page] || 1
    per_page = params[:per_page] || 10
    @alerts = current_user.alerts.where(status: status).page(page).per(per_page)
  end

  def create
    alert = current_user.alerts.new(alert_params)
    if alert.save
      render json: { alert: alert }, status: :created
    else
      render json: { errors: alert.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      alert = current_user.alerts.find(params[:id])
      alert.destroy
      render json: { message: 'Alert deleted' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Alert not found' }, status: :not_found
    end
  end

  private
    def alert_params
      params.require(:alert).permit(:coin, :target_price)
    end
end
