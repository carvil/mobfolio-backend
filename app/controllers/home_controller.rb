class HomeController < ApplicationController
  respond_to :json

  def index
    head 200
  end
end
