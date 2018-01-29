require 'rails_helper'

RSpec.describe 'Tasks API' do
  let!(:bucket) { create(:bucket) }
  let!(:tasks) { create_list(:task, 20, bucket_id: bucket.id) }
  let(:bucket_id) { bucket.id }
  let(:id) { tasks.first.id }

  describe 'GET /buckets/:id/tasks' do
    before { get "/buckets/#{bucket_id}/tasks" }

    context 'when bucket exists' do
      it '200s' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tasks for that bucket' do
        expect(json.size).to eq(20)
      end
    end

    context 'when bucket doesnt exist' do
      let(:bucket_id) { 0 }

      it '404s' do
        expect(response).to have_http_status(404)
      end

      it 'returns a `not found` error message' do
        expect(response.body).to match(/Couldn't find Bucket/)
      end
    end
  end

  describe 'GET /bucket/:id/tasks/:id' do
    before { get "/buckets/#{bucket_id}/tasks/#{id}" }

    context 'when task exists' do
      it '200s' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when task doesnt exist' do
      let(:id) { 0 }

      it '404s' do
        expect(response).to have_http_status(404)
      end

      it 'returns a `not found` error message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'POST /bucket/:bucket_id/tasks' do
    let(:valid_attributes) { { title: 'Write the tests for this', status: 'Scheduled', description: 'request specs for the tasks' } }

    context 'when task attributes are valid' do
      before { post "/buckets/#{bucket_id}/tasks", params: valid_attributes }

      it '201s' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when task attributes are invalid' do
      before { post "/buckets/#{bucket_id}/tasks", params: {} }

      it '422s' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /buckets/:bucket_id/tasks/:id' do
    let(:valid_attributes) { { title: 'Write tests nowww!!' } }

    before { put "/buckets/#{bucket_id}/tasks/#{id}", params: valid_attributes }

    context 'when task exists' do
      it '204s' do
        expect(response).to have_http_status(204)
      end

      it 'updates the task title' do
        updated_task = Task.find(id)
        expect(updated_task.title).to match(/Write tests nowww!!/)
      end
    end

    context 'when task doesnt exist' do
      let(:id) { 0 } 

      it '404s' do
        expect(response).to have_http_status(404)
      end

      it 'returns a `not found` error message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe "DELETE /buckets/:bucket_id/tasks/:id" do
    before { delete "/buckets/#{bucket_id}/tasks/#{id}" }

    it '204s' do
      expect(response).to have_http_status(204)
    end
  end
end
