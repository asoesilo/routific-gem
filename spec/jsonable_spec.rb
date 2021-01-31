require_relative './helper/spec_helper'

describe RoutificApi::Jsonable do
  let(:subject) { JsonableSubclass.new(params) }
  let(:params)  { Factory::JSONABLE_PARAMS }

  class JsonableSubclass < RoutificApi::Attributable
    include RoutificApi::Jsonable
    def values; %i(val_attr); end
    def object_values; %i(obj_val_attr); end
    def collections; %i(collection_attr); end
  end

  describe "#as_json" do
    let(:result) { subject.as_json }

    it "sets the value" do
      expect(result["val_attr"]).to eq("VALUE")
    end

    it "sets the collection's as_json value" do
      expect(result["collection_attr"].first).to eq("COLLECTION")
    end

    it "sets the object value's as_json value" do
      expect(result["obj_val_attr"]).to eq("OBJECT VALUE")
    end
  end
end
