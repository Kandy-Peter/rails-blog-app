require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'check the get request for the index posts/index' do
    it 'rcheck the http request i fit returns the page' do
      get '/users/'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('Rails BlogApp')
    end
  end

  describe 'check the get request for the index posts/show' do
    it 'check the http request i fit returns the page' do
      get '/users/1'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('This is the users:ID page')
    end
  end
end
