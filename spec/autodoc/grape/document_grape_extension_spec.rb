require 'spec_helper'

describe DocumentGrapeExtension, type: :request do
  before do
    instance_eval "#{method.to_s.downcase} path, body, header"
  end

  let(:document) do
    doc = Autodoc::Document.new(context, example)
    doc.extend DocumentGrapeExtension
    doc
  end

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

  describe '#method' do
    subject do
      document.send(:method)
    end

    it do
      expect(subject).to eq('GET')
    end
  end

  describe '#path' do
    after do
      Autodoc.configuration.grape_path_arrange = nil
    end

    describe 'default' do
      before do
        Autodoc.configuration.grape_path_arrange = nil
      end

      subject do
        document.send(:path)
      end

      it do
        expect(subject).to eq('/api/items/:id(.json)')
      end
    end

    describe 'arrange' do
      before do
        Autodoc.configuration.grape_path_arrange = -> (document) {
          document.path_pattern.gsub("(.json)",'')
        }
      end

      subject do
        document.send(:path)
      end

      it do
        expect(subject).to eq('/api/items/:id')
      end
    end
  end
end
