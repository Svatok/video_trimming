module Authenticable::User
  attr_reader :current_user

  private

  def authenticate_user!
    @current_user = User.find(authorization_id)
  rescue ActiveRecord::RecordNotFound
    head :unauthorized unless current_user
  end

  def authorization_id
    request.headers['Authorization']&.split&.last
  end
end
