RSpec::Matchers.define :match_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/schemas/api"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
