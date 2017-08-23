module Check
  module V1
    class Auth
      extend Grape::API::Helpers
      def authenticate!
        error!('Unauthorised. Invalid token', 401) unless current_user
      end

      def current_user
        token = Apikey.find_by(token: params[:token])
        if token && !token.expired?
          @current_user = User.find(token.user_id)
        else
          false
        end
      end
    end
  end
end
