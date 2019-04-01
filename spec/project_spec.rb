require_relative './helper/spec_helper'
require_relative '../lib/util'

describe RoutificApi::Project do
  describe "valid parameters" do
    subject(:project) { Factory::PROJECT }

    it "has name" do
      expect(project.name).to eq(Factory::PROJECT_NAME)
    end

    it "has date" do
      expect(project.date).to eq(Factory::PROJECT_DATE)
    end

    it "has id" do
      expect(project.id).to eq(nil)
    end

    it "has drivers"

    it "has stops" do
      expect(project.stops.class).to eq(Array)
      expect(project.stops.first).to eq(Factory::STOP)
    end

    it "has settings"

    describe "#as_json" do
      subject(:projectJSON) { project.as_json }

      it "can be reconverted to JSON" do
        expect { projectJSON }.to_not raise_error
      end

      it "has name" do
        expect(projectJSON["name"]).to eq(Factory::PROJECT_NAME)
      end

      it "has date" do
        expect(projectJSON["date"]).to eq(Factory::PROJECT_DATE)
      end

      it "has id" do
        expect(projectJSON["id"]).to eq(nil)
      end

      it "has drivers"

      it "has stops" do
        expect(Factory::STOP).to receive(:as_json).and_return("STOP JSON")
        expect(projectJSON["stops"].first).to eq("STOP JSON")
      end

      it "has settings"
    end
  end
end
