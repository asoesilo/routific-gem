class Factory
  # LOCATION_1_ID = Faker::Lorem.word
  # LOCATION_2_ID = Faker::Lorem.word
  # LOCATION_3_ID = Faker::Lorem.word

  # # Factory and constants for location
  LOCATION_NAME = Faker::Lorem.word
  LOCATION_LATITUDE = Faker::Address.latitude.to_f
  LOCATION_LONGITUDE = Faker::Address.longitude.to_f
  LOCATION_PARAMS = {
    "name"  => LOCATION_NAME,
    "lat"   => LOCATION_LATITUDE,
    "lng"   => LOCATION_LONGITUDE
    }
  LOCATION = RoutificApi::Location.new(LOCATION_PARAMS)

  # Factory and constants for visit
  VISIT_ID = Faker::Lorem.word
  VISIT_START = "08:00"
  VISIT_END = "22:00"
  VISIT_DURATION = Faker::Number.digit
  VISIT_DEMAND = Faker::Number.digit
  VISIT_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VISIT_PARAMS = {
    "start"     => VISIT_START,
    "end"       => VISIT_END,
    "duration"  => VISIT_DURATION,
    "demand"    => VISIT_DEMAND,
    "location"  => VISIT_LOCATION
  }
  VISIT = RoutificApi::Visit.new(VISIT_ID, VISIT_PARAMS)

  # Factory and constants for vehicle
  VEHICLE_ID = Faker::Lorem.word
  VEHICLE_NAME = Faker::Lorem.word
  VEHICLE_START_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VEHICLE_END_LOCATION = {
    "lat" => Faker::Address.latitude.to_f,
    "lng" => Faker::Address.longitude.to_f,
  }
  VEHICLE_SHIFT_START = "06:00"
  VEHICLE_SHIFT_END = "18:00"
  VEHICLE_CAPACITY = Faker::Number.digit
  VEHICLE_PARAMS = {
    "start_location"  => VEHICLE_START_LOCATION,
    "end_location"    => VEHICLE_END_LOCATION,
    "shift_start"     => VEHICLE_SHIFT_START,
    "shift_end"       => VEHICLE_SHIFT_END,
    "capacity"        => VEHICLE_CAPACITY
    }
  VEHICLE = RoutificApi::Vehicle.new(VEHICLE_ID, VEHICLE_PARAMS)

  # Factory and constants for way point
  WAY_POINT_LOCATION_ID = Faker::Lorem.word
  WAY_POINT_ARRIVAL_TIME = "09:00"
  WAY_POINT_FINISH_TIME = "09:10"
  WAY_POINT = RoutificApi::WayPoint.new( WAY_POINT_LOCATION_ID,
    WAY_POINT_ARRIVAL_TIME, WAY_POINT_FINISH_TIME )

  # Factory and constants for route
  ROUTE_STATUS = Faker::Lorem.word
  ROUTE_FITNESS = Faker::Lorem.word
  ROUTE_UNSERVED = [Faker::Lorem.word]
  ROUTE = RoutificApi::Route.new( ROUTE_STATUS, ROUTE_FITNESS, ROUTE_UNSERVED )

  ROUTE_API_RESPONSE = {
    'status'            => 'success',
    'total_travel_time' => 69.03333,
    'total_idle_time'   => 139.08333,
    'num_unserved'      => 0,
    'unserved'          => nil,
    'solution' => {
      'vehicle_1' => [
        { 'location_id' => 'vehicle_1_start', 'location_name' => 'Nameless Node', 'arrival_time' => '17:30' },
        { 'location_id' => '5476', 'location_name' => 'Nameless Node', 'arrival_time' => '17:32', 'idle_time' => 27.866667, 'finish_time' => '18:05' }
      ],
      'vehicle_2' => [
        { 'location_id' => 'vehicle_2_start', 'location_name' => 'Nameless Node', 'arrival_time' => '17:30' },
        { 'location_id' => '5481', 'location_name' => 'Nameless Node', 'arrival_time' => '17:32', 'idle_time' => 27.833334, 'finish_time' => '18:05' }
      ],
      'vehicle_3' => [
        { 'location_id' => 'vehicle_3_start', 'location_name' => 'Nameless Node', 'arrival_time' => '17:30' },
        { 'location_id' => '5485', 'location_name' => 'Nameless Node', 'arrival_time' => '17:32', 'idle_time' => 27.833334, 'finish_time' => '18:05' },
        { 'location_id' => '5480', 'location_name' => 'Nameless Node', 'arrival_time' => '18:09', 'finish_time' => '18:14' },
        { 'location_id' => '5479', 'location_name' => 'Nameless Node', 'arrival_time' => '18:16', 'finish_time' => '18:21' },
        { 'location_id' => '5493', 'location_name' => 'Nameless Node', 'arrival_time' => '18:24', 'finish_time' => '18:29' },
        { 'location_id' => '5474', 'location_name' => 'Nameless Node', 'arrival_time' => '18:29', 'finish_time' => '18:34' },
        { 'location_id' => '5490', 'location_name' => 'Nameless Node', 'arrival_time' => '18:38', 'finish_time' => '18:43' },
        { 'location_id' => '5491', 'location_name' => 'Nameless Node', 'arrival_time' => '18:46', 'finish_time' => '18:51' },
        { 'location_id' => '5475', 'location_name' => 'Nameless Node', 'arrival_time' => '18:52', 'finish_time' => '18:57' },
        { 'location_id' => '5495', 'location_name' => 'Nameless Node', 'arrival_time' => '18:57', 'finish_time' => '19:02' },
        { 'location_id' => '5492', 'location_name' => 'Nameless Node', 'arrival_time' => '19:05', 'finish_time' => '19:10' },
        { 'location_id' => '5494', 'location_name' => 'Nameless Node', 'arrival_time' => '19:14', 'finish_time' => '19:19' },
        { 'location_id' => '5473', 'location_name' => 'Nameless Node', 'arrival_time' => '19:25', 'finish_time' => '19:30' }
      ],
      'vehicle_4' => [
        { 'location_id' => 'vehicle_4_start', 'location_name' => 'Nameless Node', 'arrival_time' => '17:30' },
        { 'location_id' => '5482', 'location_name' => 'Nameless Node', 'arrival_time' => '17:33', 'idle_time' => 26.583334, 'finish_time' => '18:05' }
      ],
      'vehicle_5' => [
        { 'location_id' => 'vehicle_5_start', 'location_name' => 'Nameless Node', 'arrival_time' => '17:30' },
        { 'location_id' => '5483', 'location_name' => 'Nameless Node', 'arrival_time' => '17:31', 'idle_time' => 28.966667, 'finish_time' => '18:05' },
        { 'location_id' => '5477', 'location_name' => 'Nameless Node', 'arrival_time' => '18:07', 'finish_time' => '18:12' },
        { 'location_id' => '5484', 'location_name' => 'Nameless Node', 'arrival_time' => '18:14', 'finish_time' => '18:19' },
        { 'location_id' => '5469', 'location_name' => 'Nameless Node', 'arrival_time' => '18:21', 'finish_time' => '18:26' },
        { 'location_id' => '5478', 'location_name' => 'Nameless Node', 'arrival_time' => '18:29', 'finish_time' => '18:34' },
        { 'location_id' => '5486', 'location_name' => 'Nameless Node', 'arrival_time' => '18:39', 'finish_time' => '18:44' },
        { 'location_id' => '5487', 'location_name' => 'Nameless Node', 'arrival_time' => '18:48', 'finish_time' => '18:53' },
        { 'location_id' => '5468', 'location_name' => 'Nameless Node', 'arrival_time' => '18:57', 'finish_time' => '19:02' },
        { 'location_id' => '5488', 'location_name' => 'Nameless Node', 'arrival_time' => '19:04', 'finish_time' => '19:09' },
        { 'location_id' => '5489', 'location_name' => 'Nameless Node', 'arrival_time' => '19:13', 'finish_time' => '19:18' }
      ]
    }
  }
  JOB_API_RESPONSE = {
    'started_at'  => '2015-12-14T11:40:34.001Z',
    'finished_at' => '2015-12-14T11:40:35.008Z',
    'id'          => 'ii5w2kb5846',
    'opts'        => { 'traffic' => 1, 'problem' => 'vrp' },
    'status'      => 'finished',
    'visits'      => 30,
    'fleet'       => 5,
    'region'      => 'europe',
    'output'      => ROUTE_API_RESPONSE
  }
end
