require 'rails_helper'

RSpec.describe 'Buckets API', type: :request do
  let!(:buckets) { create_list(:bucket, 10) }
  let(:bucket_id) { buckets.first.id }

  describe 'Get /buckets' do
    before { get '/buckets' }

    it 'returns buckets' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /buckets/:id' do
    before { get "/buckets/#{bucket_id}" }

    context 'when the bucket exists' do
      it 'returns the bucket' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bucket_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when bucket doesnt exist' do
      let(:bucket_id) { 9000 }

      it '404s' do
        expect(response).to have_http_status(404)
      end

      it 'returns a `couldnt find` error message' do
        expect(response.body).to match(/Couldn't find Bucket/)
      end
    end
  end

  describe 'POST /buckets' do
    let(:valid_attributes) { { title: 'Coding things', description: 'The things I want to code' } }

    context 'when request params are valid' do
      before { post '/buckets', params: valid_attributes }

      it 'creates a bucket' do
        expect(json['title']).to eq('Coding things')
        expect(json['description']).to eq('The things I want to code')
      end

      it '201s' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request params are invalid' do
      before { post '/buckets', params: { title: '¿no descripción?' } }

      it '422s' do
        expect(response).to have_http_status(422)
      end

      it 'returns validation failure message: description cant be blank' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  describe 'PUT /buckets/:id' do
    let(:valid_attributes) { { title: 'Things I want to code' } }

    context 'when the bucket exists' do
      before { put "/buckets/#{bucket_id}", params: valid_attributes }

      it 'updates the bucket title' do
        expect(response.body).to be_empty
      end

      it '204s' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /buckets/:id' do
    before { delete "/buckets/#{bucket_id}" }

    it '204s' do
      expect(response).to have_http_status(204)
    end
  end
end
