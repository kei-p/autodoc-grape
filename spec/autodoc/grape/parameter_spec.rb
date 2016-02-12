class Dummy::API < Grape::API
  params do
    requires :number, type: Integer
    requires :text, type: String

    requires :hash, type: Hash do
      requires :hash_attr, type: Integer
      requires :deep_hash, type: Hash do
        requires :deep_hash_attr, type: Integer
      end
    end
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

    context "hash" do
      let(:validator_name) { "hash" }
      it { expect(subject).to eq("* hash Hash") }
    end

    context "hash[hash_attr]" do
      let(:validator_name) { "hash[hash_attr]" }
      it { expect(subject).to eq(" * hash_attr Integer") }
    end

    context "hash[deep_hash]" do
      let(:validator_name) { "hash[deep_hash]" }
      it { expect(subject).to eq(" * deep_hash Hash") }
    end

    context "hash[deep_hash][deep_hash_attr]" do
      let(:validator_name) { "hash[deep_hash][deep_hash_attr]" }
      it { expect(subject).to eq("  * deep_hash_attr Integer") }
    end
  end
end
