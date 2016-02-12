class Dummy::API < Grape::API
  params do
    requires :number, type: Integer
    requires :text, type: String
  end
  get '/' do end
end

describe Autodoc::Grape::Document::Parameter do
  let(:paramter) { Autodoc::Grape::Document::Parameter.new(validator) }
  let(:validators) { Dummy::API.routes.first.instance_variable_get(:@options)[:params].to_a }
  let(:validator) { validators.find { |v| v[0] == validator_name }  }

  describe "#to_s" do
    subject { paramter.to_s }

    context "number" do
      let(:validator_name) { "number" }
      it { expect(subject).to eq("* number Integer") }
    end

    context "text" do
      let(:validator_name) { "text" }
      it { expect(subject).to eq("* text String") }
    end
  end
end
