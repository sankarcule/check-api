module Check
  module V1
    class Authentication < Grape::API
      version 'v1', using: :path, vendor: 'twitter'
      format :json
      prefix :api

      resource :auth do
        desc 'login'
        params do
          requires :email, type: String, desc: 'email'
          requires :password, type: String, desc: 'password'
        end
        post '/login' do
          user = User.find_by(email: params[:email])
          if user.present?
            if user.password === params[:password]
              ApiKey.create(user_id: user.id)
              present user, with: Entities::Users::Base
            else
              error!('Wrong password', 400)
            end
          else
            error!('User not present', 400)
          end
        end

        desc 'register'
        params do
          requires :email, type: String, desc: 'email'
          requires :password, type: String, desc: 'password'
          requires :password_comfirmation, type: String, desc: 'password confim'
        end
        post '/register' do
          user = User.find_by(email: params[:email])
          if user
            error!('User present', 400)
          else
            new_user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
            begin
              new_user.save!
            rescue => e
              error!(new_user.errors, 400)
            else
              ApiKey.create(user_id: new_user.id)
              present new_user, with: Entities::Users::Base
            end
          end
        end

        desc 'logout'
        params do
          requires :token, type: String, desc: 'token'
        end
        post '/logout' do
          api = ApiKey.find_by(token: params[:token])
          api.update(expires_at: DateTime.now)
        end
      end
    end
  end
end
