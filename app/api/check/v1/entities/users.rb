module Check::V1::Entities::Users
  class Base < ::Grape::Entity
    expose :id
    expose :email
    expose :token do |obj, opts|
      Apikey.where(user_id: obj.id).last.access_token if ApiKey.where(user_id: obj.id).present?
    end
  end

  class Userbase < ::Grape::Entity
    expose :id
    expose :email
    expose :token do |obj, opts|
      Apikey.where(user_id: obj.id).last.access_token if ApiKey.where(user_id: obj.id).present?
    end
  end
end
