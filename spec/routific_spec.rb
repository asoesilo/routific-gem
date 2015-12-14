require_relative './helper/spec_helper'

describe Routific do
  let(:endpoints) { %w(vrp vrp-long pdp pdp-long) }

  describe "instance methods" do
    subject(:routific) { Routific.new(ENV["API_KEY"]) }

    it "has token" do
      expect(routific.token).to eq(ENV["API_KEY"])
    end

    describe '#endpoint' do
      it 'returns the default endpoint' do
        expect(routific.endpoint).to eq(:vrp)
      end
    end

    describe '#endpoint=' do
      around do |example|
        old_endpoint = routific.endpoint
        example.run
        routific.endpoint = old_endpoint
      end

      it 'changes the endpoint if a valid endpoint is given' do
        endpoints.each do |endpoint|
          routific.endpoint = endpoint
          expect(routific.endpoint).to eq(endpoint)
        end
      end

      it 'raises an error if an invalid endpoint is given' do
        expect { routific.endpoint = 'invalid' }.to raise_error(Routific::InvalidEndpoint)
      end
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

    describe "#setVisit" do
      let(:id) { Faker::Lorem.word }
      before do
        routific.setVisit(id, Factory::VISIT_PARAMS)
      end

      it "adds location 1 into visits" do
        expect(routific.visits).to include(id)
      end

      it "location 1 in visits is instances of Visit" do
        expect(routific.visits[id]).to be_instance_of(RoutificApi::Visit)
      end
    end

    describe "#setVehicle" do
      let(:id) { Faker::Lorem.word }

      before do
        routific.setVehicle(id, Factory::VEHICLE_PARAMS)
      end

      it "adds vehicle into fleet" do
        expect(routific.fleet).to include(id)
      end

      it "vehicle in fleet is instances of Vehicle" do
        expect(routific.fleet[id]).to be_instance_of(RoutificApi::Vehicle)
      end
    end

    describe "#getRoute" do
      before do
        routific.setVisit("order_1", {
          "start" => "9:00",
          "end" => "12:00",
          "duration" => 10,
          "location" => {
            "name" => "6800 Cambie",
            "lat" => 49.227107,
            "lng" => -123.1163085,
          }
        })

        routific.setVehicle("vehicle_1", {
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

      it "returns a Route instance" do
        route = routific.getRoute()
        expect(route).to be_instance_of(RoutificApi::Route)
      end
    end
  end

  describe "class methods" do
    describe '.endpoint' do
      it 'returns the default endpoint' do
        expect(Routific.endpoint).to eq(:vrp)
      end
    end

    describe '.endpoint=' do
      around do |example|
        old_endpoint = Routific.endpoint
        example.run
        Routific.endpoint = old_endpoint
      end

      it 'changes the endpoint if a valid endpoint is given' do
        endpoints.each do |endpoint|
          Routific.endpoint = endpoint
          expect(Routific.endpoint).to eq(endpoint)
        end
      end

      it 'raises an error if an invalid endpoint is given' do
        expect { Routific.endpoint = 'invalid' }.to raise_error(Routific::InvalidEndpoint)
      end

      it 'changes the endpoint for all new instances' do
        endpoints.each do |endpoint|
          Routific.endpoint = endpoint
          expect(Routific.new(ENV["API_KEY"]).endpoint).to eq(endpoint)
        end
      end
    end

    describe ".setToken" do
      before do
        Routific.setToken(ENV["API_KEY"])
      end

      it "sets default Routific API token" do
        expect(Routific.token).to eq(ENV["API_KEY"])
      end
    end

    describe ".getRoute" do
      describe "access token is nil" do
        it "throws an ArgumentError" do
          expect { Routific.getRoute({}, nil) }.to raise_error(ArgumentError)
        end
      end

      describe "valid access token" do
        before do
          visits = {
            "order_1" => {
              "start" => "9:00",
              "end" => "12:00",
              "duration" => 10,
              "location" => {
                "name" => "6800 Cambie",
                "lat" => 49.227107,
                "lng" => -123.1163085
              }
            }
          }
          fleet = {
            "vehicle_1" => {
              "start_location" => {
                "name" => "800 Kingsway",
                "lat" => 49.2553636,
                "lng" => -123.0873365
              },
              "end_location" => {
                "name" => "800 Kingsway",
                "lat" => 49.2553636,
                "lng" => -123.0873365
              },
              "shift_start" => "8:00",
              "shift_end" => "12:00"
            }
          }
          @data = {
            visits: visits,
            fleet: fleet
          }
        end

        describe "access token is set" do
          before do
            Routific.setToken(ENV["API_KEY"])
          end

          it "returns a Route instance" do
            expect(Routific.getRoute(@data)).to be_instance_of(RoutificApi::Route)
          end
        end

        describe "access token is provided" do
          before do
            Routific.setToken(nil)
          end

          it "returns a Route instance" do
            expect(Routific.getRoute(@data, ENV["API_KEY"])).to be_instance_of(RoutificApi::Route)
          end

          it "still successful even if missing prefix 'bearer ' in key" do
            key = ENV["API_KEY"].sub /bearer /, ''
            expect(/bearer /.match(key).nil?).to be true
            expect(Routific.getRoute(@data, key)).to be_instance_of(RoutificApi::Route)
          end
        end
      end
    end
  end
end
