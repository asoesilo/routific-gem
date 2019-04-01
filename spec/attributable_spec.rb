require_relative './helper/spec_helper'

describe RoutificApi::Attributable do
  let(:subject) { AttributableSubclass.new(params) }
  let(:params)  { Factory::ATTRIBUTABLE_PARAMS }

  class AttributableSubclass < RoutificApi::Attributable
    def values; %i(val_attr); end
    def object_values; %i(obj_val_attr); end
    def collections; %i(collection_attr); end
  end

  describe "instance variables" do
    it "has value" do
      expect(subject.val_attr).to eq("VALUE")
    end

    context "valid collections" do
      it "has collections" do
        expect(subject.collection_attr.class).to eq(Array)
        expect(subject.collection_attr.first).to eq("COLLECTION")
      end
    end

    context "invalid collections" do
      let(:params) { Factory::ATTRIBUTABLE_PARAMS_INVALID_COLLECTION }

      it "raises an error" do
        expect { subject }.to raise_error(NotArrayError)
      end
    end
  end

  context "attributes not set" do
    it "raises a missing attribute error" do
      %i(values object_values collections).each do |meth|
        AttributableSubclass.class_eval("undef #{ meth }")
        expect { subject }.to raise_error(MissingAttributeError)
      end
    end
  end
end
