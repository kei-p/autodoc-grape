module API
  class Root < Grape::API
    prefix 'api'
    format :json

    resource :items do

      params do
        requires :id, type: Integer
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
