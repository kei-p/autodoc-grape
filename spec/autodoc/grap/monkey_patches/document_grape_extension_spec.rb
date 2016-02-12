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

  let(:route_info) do
    API::Root.routes.find { |route| Regexp.new("/api/items/:id").match(route.instance_variable_get(:@options)[:path]) }
  end

  describe '#grape_request?' do
    subject do
      document.send(:grape_request?)
    end

    it { expect(subject).to eq(true) }
  end

  describe '#route_info' do
    subject do
      document.send(:route_info)
    end

    it do
      expect(subject).to eq(route_info)
    end
  end
end
