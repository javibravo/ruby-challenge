Rails.application.routes.draw do
  scope '/api' do
    scope module: :v1 do
      scope '/v1' do
        scope 'file' do
          post '/' => 'api_file#create'
        end
      end
    end
  end
end
