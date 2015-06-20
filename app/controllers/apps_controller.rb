class AppsController < ApplicationController
  respond_to :json

  def index
    render json: {apps: App.all}
  end

  def update
    app = App.find(params[:id])
    app.update_attributes(name: params[:name])
    render json: { app: app }
  end

  def show
    render json: { app: App.find(params[:id]) }
  end

  def create
    app = App.new(app_params)
    app.save
    render json: { app: app.as_json }, status: 201
  end

  private

  def app_params
    params.require(:app).permit(:name, :user_id)
  end
end
