require 'spec_helper'

describe Autodoc::Documents do
  describe '#append' do
    subject do
      instance_eval "#{method.to_s.downcase} path, body, header"

      dummy_documents.append(context, example)
    end

    let(:dummy_documents) { Autodoc::Documents.new }

    let(:context) do
      if ::RSpec::Core::Version::STRING.match /\A(?:3|2\.99)\./
        mock = double(example: example, request: request, file_path: file_path, full_description: full_description)
      else
        mock = double(example: example, request: request)
      end

      if ::RSpec::Core::Version::STRING.split('.').first == "3"
        allow(mock).to receive_messages(clone: mock)
      else
        mock.stub(clone: mock)
      end
      mock
    end

    let(:example) do
      mock = double(file_path: file_path, full_description: full_description)

      if ::RSpec::Core::Version::STRING.split('.').first == "3"
        allow(mock).to receive_messages(clone: mock)
      else
        mock.stub(clone: mock)
      end
      mock
    end

    let(:header) { nil }
    let(:body) { nil }

    context 'grape api', type: :request do
      let(:path) { '/api/items/1' }
      let(:method) { 'GET' }
      let(:body) { nil }

      let(:full_description) do
        "Items #{method} #{path} return item"
      end

      let(:file_path) do
        "./spec/requests/items_spec.rb"
      end

      let(:document) do
        dummy_documents.instance_variable_get(:@table)[Pathname.new("spec/dummy/doc/items.md")]
      end

      it '' do
        expect { subject }.to change { document.count }.to(1)
      end
    end
  end
end
