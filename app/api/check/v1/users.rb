module Check
  module V1
    class Users < Grape::API
      helpers Auth
      version 'v1', using: :path, vendor: 'twitter'
      format :json
      prefix :api

      resource :users do
        before do
          authenticate!
        end

        desc 'list users'
        params do
          requires :token, type: String, desc: 'access token'
        end
        get '/' do
          present User.all, with: Entities::Users::Userbase
        end

        namespace '/current_user' do
          desc 'user detail'
          params do
            requires :token, type: String, desc: 'aceess token'
          end
          get '/' do
            present current_user, with: Entities::Users::Userbase
          end

          # desc 'update details' do
          #   params do
          #     requires :token, type: String, desc: 'token'
          #     requires :current_password, type: String, desc: 'current password'
          #     requires :new_password, type: String, desc: 'new password'
          #   end
          #   patch '/update_user' do
          #     if current_user.password === params[:current_password]
          #       begin
          #         # current_user.update(password: params[:new_password])
          #         present current_user , with: Entities::Users::UserBase
          #       rescue Exception  => e
          #         error!(e.message, 400)
          #       end
          #     else
          #       error!('wrong password', 400)
          #     end
          #   end
          # end
        end
      end
    end
  end
end
