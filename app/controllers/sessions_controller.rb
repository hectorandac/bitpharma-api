# frozen_string_literal: true


class SessionsController < Devise::SessionsController
  include ActionController::Cookies
  respond_to :json

  api :POST, '/login', 'Sign user in'
  param :user, Hash, required: true, desc: 'User info' do
    param :email, String, desc: 'User email'
    param :password, String, desc: 'User password'
  end
  def create
    super
    p resource.email
    cookies[:user_email] = resource.email
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource.sanitized_info
  end

  def respond_to_on_destroy
    head :no_content
  end
end
