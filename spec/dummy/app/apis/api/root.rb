module API
  class Root < Grape::API
    prefix 'api'
    format :json

    resource :items do

      params do
        requires :id, type: Integer
        optional :hash, type: Hash do
          requires :attr, type: String
        end
      end
      get ':id' do
        {
          id: params[:id],
          name: 'item'
        }
      end
    end
  end
end
