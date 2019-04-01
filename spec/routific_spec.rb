require_relative './helper/spec_helper'
require_relative '../lib/util'

describe Routific do
  describe "without token" do
    before do
      Routific.class_variable_set :@@token, nil
    end

    it "cannot be instantiated without token" do
      expect{Routific.new()}.to raise_error(ArgumentError)
    end
  end

  describe "instance objects" do
    routific = nil
    before do
      Routific.set_token(ENV["API_KEY"])
      routific = Routific.new()
    end

    it "has token" do
      expect(Routific.token).to eq(Util.prefix_token(ENV["API_KEY"]))
    end

    describe "#visits" do
      it "is instance of a Hash" do
        expect(routific.visits).to be_instance_of(Hash)
      end
    end

    describe "#fleet" do
      it "is instance of a Hash" do
        expect(routific.fleet).to be_instance_of(Hash)
      end
    end

    describe "#options" do
      it "is instance of a Routific::Options" do
        routific.set_options(Factory::ROUTE_OPTIONS_PARAMS)
        expect(routific.options).to be_instance_of(RoutificApi::Options)
      end
    end

    describe "#set_visit" do
      let(:id) { Faker::Lorem.word }
      before do
        routific.set_visit(id, Factory::VISIT_PARAMS)
      end

      it "adds location 1 into visits" do
        expect(routific.visits).to include(id)
      end

      it "location 1 in visits is instances of Visit" do
        expect(routific.visits[id]).to be_instance_of(RoutificApi::Visit)
      end
    end

    describe "#set_vehicle" do
      let(:id) { Faker::Lorem.word }

      before do
        routific.set_vehicle(id, Factory::VEHICLE_PARAMS)
      end

      it "adds vehicle into fleet" do
        expect(routific.fleet).to include(id)
      end

      it "vehicle in fleet is instances of Vehicle" do
        expect(routific.fleet[id]).to be_instance_of(RoutificApi::Vehicle)
      end
    end

    describe "#set_options" do
      before do
        routific.set_options(Factory::ROUTE_OPTIONS_PARAMS)
      end

      it "adds an options hash into options" do
        expect(routific.options.traffic).to eq(Factory::ROUTE_OPTIONS_TRAFFIC)
        expect(routific.options.min_visits_per_vehicle).to eq(Factory::ROUTE_OPTIONS_MIN_VISITS_PER_VEHICLE)
        expect(routific.options.balance).to eq(Factory::ROUTE_OPTIONS_BALANCE)
        expect(routific.options.min_vehicles).to eq(Factory::ROUTE_OPTIONS_MIN_VEHICLES)
        expect(routific.options.shortest_distance).to eq(Factory::ROUTE_OPTIONS_SHORTEST_DISTANCE)
      end

      it "options is instance of RoutificApi::Options" do
        expect(routific.options).to be_instance_of(RoutificApi::Options)
      end
    end

    def set_visit_and_vehicle(routific)
      routific.set_visit("order_1", {
        "start" => "9:00",
        "end" => "12:00",
        "duration" => 10,
        "location" => {
          "name" => "6800 Cambie",
          "lat" => 49.227107,
          "lng" => -123.1163085,
        }
      })

      routific.set_vehicle("vehicle_1", {
        "start_location" => {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365,
        },
        "end_location" => {
          "name" => "800 Kingsway",
          "lat" => 49.2553636,
          "lng" => -123.0873365,
        },
        "shift_start" => "8:00",
        "shift_end" => "12:00",
      })
    end

    describe "#get_route" do
      before do
        set_visit_and_vehicle routific
      end

      it "returns a Route instance" do
        route = routific.get_route()
        expect(route).to be_instance_of(RoutificApi::Route)
      end

      it "attaches optional data hash" do
        routific.set_options({
          "traffic" => "slow"
        })

        data = {
          visits: routific.visits,
          fleet: routific.fleet,
          options: routific.options
        }

        route = routific.get_route()
        expect(route).to be_instance_of(RoutificApi::Route)
      end
    end

    describe "#get_route_async" do
      before do
        job = nil
        set_visit_and_vehicle routific
      end

      it "returns a Job instance" do
        job = routific.get_route_async()
        expect(job).to be_instance_of(RoutificApi::Job)
        expect(job.id).to be_instance_of(String)
        expect(job.input).to be_instance_of(Hash)
        expect(job.status).to eq('pending')
        sleep 1
        expect(job.fetch).to eq('finished')
        expect(job.route).to be_instance_of(RoutificApi::Route)
      end
    end

    describe "#set_project" do
      let(:result) { routific.set_project(data) }
      let(:data) { Factory::PROJECT_DATA }

      it "returns a Project instance" do
        expect(result).to be_instance_of(RoutificApi::Project)
      end
    end
  end

  describe "class methods" do
    describe ".set_token" do
      before(:each) do
        Routific.class_variable_set :@@token, nil
      end

      it "sets Routific API token" do
        Routific.set_token("bearer token")
        expect(Routific.token).to eq("bearer token")
      end

      it "sets Routific API token, prefixing \"bearer\" if absent" do
        Routific.set_token("token")
        expect(Routific.token).to eq("bearer token")
      end

      it "throws an ArgumentError if token is not passed in" do
        expect{Routific.set_token(nil)}.to raise_error(ArgumentError)
      end
    end
  end
end
