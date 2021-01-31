require_relative './helper/spec_helper'

RSpec.describe RoutificApi::ProjectFactory do
  let(:subject) { described_class.new(params) }
  let(:params)  { Factory::PROJECT_FACTORY_PARAMS }

  describe "#call" do
    let(:result) { subject.call }

    it "returns a project" do
      expect(result.class).to eq(RoutificApi::Project)
    end

    describe "#drivers" do
      it "is an array of Driver" do
        expect(result.drivers.first.class).to eq(RoutificApi::Driver)
      end

      describe "locations" do
        it "is an instance of ProjectLocation" do
          expect(result.drivers.first.start_location.class).to eq(RoutificApi::ProjectLocation)
          expect(result.drivers.first.end_location.class).to eq(RoutificApi::ProjectLocation)
        end
      end
    end

    describe "#stops" do
      it "is an array of Stop" do
        expect(result.stops.first.class).to eq(RoutificApi::Stop)
      end
    end

    describe "#settings" do
      it "is an instance of Setting" do
        expect(result.settings.class).to eq(RoutificApi::Setting)
      end
    end
  end
end
