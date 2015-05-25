class RegistrationsController < Devise::RegistrationsController
  before_filter :expose

  respond_to :json

  def expose
    puts params.inspect
    true
  end
end
