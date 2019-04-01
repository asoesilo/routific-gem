require_relative './helper/spec_helper'

RSpec.describe RoutificApi::ProjectFactory, focus: true do
  let(:subject) { described_class.new(params) }
  let(:params)  { Factory::PROJECT_FACTORY_PARAMS }

  describe "#call" do
    let(:result) { subject.call }

    it "returns a project" do
      expect(result.class).to eq(RoutificApi::Project)
    end
  end
end
