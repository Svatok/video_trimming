module Helpers
  def fixture_path
    "#{::Rails.root}/spec/fixtures"
  end

  def authorization_header_for(user)
    { Authorization: "Bearer #{user.id}" }
  end
end
