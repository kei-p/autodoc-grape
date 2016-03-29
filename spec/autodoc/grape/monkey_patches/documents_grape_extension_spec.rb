require 'spec_helper'

describe DocumentsGrapeExtension, type: :request do
  before do
    instance_eval "#{method.to_s.downcase} path, body, header"
  end
  let(:documents) { Autodoc::Documents.new }

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
      documents.grape_request?(context.request)
    end

    it { expect(subject).to eq(true) }
  end

  describe '#append' do
    subject do
      documents.append(context, example)
    end

    it { expect(subject.last.singleton_class.included_modules).to be_include(DocumentGrapeExtension) }
  end
end
