require_relative './helper/spec_helper'
require_relative '../lib/routific/util'

describe RoutificApi::Job do
  describe "valid parameters" do
    subject(:job) { Factory::JOB }

    it "has id" do
      expect(job.id).to eq(Factory::JOB_ID)
    end

    it "has has status" do
      expect(job.status).to eq("pending")
    end

    it "has input" do
      expect(job.input).to eq(Factory::JOB_INPUT)
    end

    describe "fetch" do
      before do
        allow(RoutificApi::Util).to receive(:send_request) { Factory::JOB_PARAMS }
        job.fetch
      end

      Factory::JOB_PARAMS.each do |key, value|
        next if key == "id" or key == "output"
        it "updates #{key}" do
          expect(eval("job.#{key}")).to eq(value)
        end
      end

      it "updates route" do
        job.route.instance_variables.each do |var|
          expect(job.route.instance_variable_get var).to eq(Factory::ROUTE.instance_variable_get var)
        end
      end
    end
  end
end
