require 'grape-swagger'
module Check
  class API < Grape::API
    prefix :api
    format :json
    version :v1

    mount Check::API::V1::ROOT

    add_swagger_documentation \
      mout_path: '/swagger_doc'

  end
end
