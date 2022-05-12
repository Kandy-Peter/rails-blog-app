require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'check the get request for the index posts/index' do
    it 'check the http request i fit returns the page' do
      get '/users/1/posts'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('post pages')
    end

    describe 'check the get request for the index posts/show' do
      it 'check the http request i fit returns the page' do
        get '/users/1/posts/1'
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(response.body).to include('Post details pages')
      end
    end
  end
end
