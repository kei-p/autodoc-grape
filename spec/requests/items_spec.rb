require 'spec_helper'

describe 'Items', type: :request do

  let(:header) { nil }
  let(:body) { nil }

  describe 'GET /items/:id'do
    subject do
      instance_eval "#{method.to_s.downcase} path, body, header"

    end

    before do
      subject
    end

    let(:path) { "/api/items/#{item_id}" }
    let(:method) { 'GET' }
    let(:body) { nil }

    let(:item_id) { 1 }

    context '', autodoc: true do
      it 'return item' do
        expect(response.status).to eq(200)
      end
    end
  end
end
