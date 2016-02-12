class Dummy::API < Grape::API
  params do
    optional :number, type: Integer
    requires :text, type: String
    optional :restricted_values, type: Integer, values: [1,2,3]
    optional :restricted_values_range, type: Integer, values: -10..+10
    optional :desc_value, type: Integer, desc: 'description'
    optional :default_value, type: Integer, default: 0

    optional :hash, type: Hash do
      optional :hash_attr, type: Integer
      optional :deep_hash, type: Hash do
        optional :deep_hash_attr, type: Integer
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
      it { expect(subject).to eq("* text String (required)") }
    end

    context "restricted_values" do
      let(:validator_name) { "restricted_values" }
      it { expect(subject).to eq("* restricted_values Integer (only: `[1, 2, 3]`)") }
    end

    context "restricted_values_range" do
      let(:validator_name) { "restricted_values_range" }
      it { expect(subject).to eq("* restricted_values_range Integer (only: `-10..10`)") }
    end

    context "desc_value" do
      let(:validator_name) { "desc_value" }
      it { expect(subject).to eq("* desc_value Integer - description") }
    end
    context "default_value" do
      let(:validator_name) { "default_value" }
      it { expect(subject).to eq("* default_value Integer (default: `0`)") }
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
