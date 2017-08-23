module Check
  module V1
    class ROOT < Grape::API
      insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger

      mount Check::V1::Authentication
      mount Check::V1::Users
    end
  end
end
