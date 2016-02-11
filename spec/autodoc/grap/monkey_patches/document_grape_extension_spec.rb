require 'spec_helper'

describe DocumentGrapeExtension, type: :request do
  before do
    instance_eval "#{method.to_s.downcase} path, body, header"
  end

  let(:document) { Autodoc::Document.new(context, example)  }

  let(:example) { self }
  let(:env) { request.env }
  let(:context) do
    if ::RSpec::Core::Version::STRING.match /\A(?:3|2\.99)\./
      mock = double(example: example, request: request, file_path: file_path, full_description: full_description, env: env)
    else
      mock = double(example: example, request: request, env: env)
    end

    if ::RSpec::Core::Version::STRING.split('.').first == "3"
      allow(mock).to receive_messages(clone: mock)
    else
      mock.stub(clone: mock)
    end
    mock
  end

  let(:header) { nil }
  let(:path) { '/api/items/1' }
  let(:method) { 'GET' }
  let(:body) { nil }
  let(:full_description) { '' }
  let(:file_path) { '' }

  describe '#grape_request?' do
    subject do
      document.send(:grape_request?)
    end

    it { expect(subject).to eq(true) }
  end
end
