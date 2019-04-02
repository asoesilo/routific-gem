Routific Ruby Gem
=================

[![Build Status](https://travis-ci.org/routific/routific-gem.svg?branch=master)](https://travis-ci.org/routific/routific-gem)

This Ruby Gem assists users to easily access the [Routific API][1], which is a practical and scalable solution to the Vehicle Routing Problem.

  [1]: https://routific.com/developers

Please refer to the full [documentation](https://docs.routific.com) for a detailled documentation of the API.

Installing
----------

`gem install routific`

Usage
-----
Remember to require it and set your token before using it

```ruby
require 'routific'
Routific.set_token("YOUR_API_KEY_HERE")
routific = Routific.new

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

routific.set_visit("order_2", {
  "start" => "9:00",
  "end" => "12:00",
  "duration" => 10,
  "location" => {
    "name"=> "3780 Arbutus",
    "lat"=> 49.2474624,
    "lng"=> -123.1532338
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

route = routific.get_route()


puts route.status # => "success"
puts route.total_travel_time # => 29

vehicle_routes = route.vehicle_routes

v1_route = vehicle_routes["vehicle_1"]
puts v1_route.length # => 4 (start -> order_1 -> order_2 -> end)

v1_route.each do |w|
  puts "#{w.location_id}: #{w.arrival_time} ~ #{w.finish_time}"
end
# vehicle_1_start: 08:49 ~
# order_1: 09:00 ~ 09:10
# order_2: 09:18 ~ 09:28
# vehicle_1_end: 09:38 ~

```

### Class methods

`Routific.set_token( token )` sets the authentication token to use.

### Instance methods

#### `routific.set_visit( id, params )`

Sets a visit with the specified id and parameters:

- `location` (*required*): Object representing the location of the visit.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location
- `start`: the earliest time for this visit. Default value is 00:00, if not specified.
- `end`: the latest time for this visit. Default value is    23:59, if not specified.
- `duration`: the length of this visit in minutes
- `demand`: the capacity that this visit requires
- `priority`: higher priority visits are more likely to be served
- `type`: restrict the vehicle that can serve this visit
- `time_windows`: specify different time-windows for serving the visit.
It should be an array of hashes: `[ { "start" => "08:00", "end" => "12:00" } ]`

#### `routific.set_vehicle( id, params )`

Sets a vehicle with the specified ID and parameters:
- `start_location` (*required*): Object representing the start location for this vehicle.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location
- `end_location`: Object representing the end location for this vehicle.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location
- `shift_start`: this vehicle's start shift time (e.g. '08:00'). Default value is 00:00, if not specified.
- `shift_end`: this vehicle's end shift time (e.g. '17:00'). Default value is 23:59, if not specified.
- `capacity`: the capacity that this vehicle can load
- `type`: restrict the visit this vehicle can serve
- `speed`: vehicle speed
- `min_visits`: minimum number of visits that should be assigned to this vehicle
- `strict_start`: force the departure time to be `shift_start`
- `breaks`: specify breaks for the driver.
It should be an array of hashes: `[ { "id" => "lunch", "start" => "12:00", "end" => "12:30" } ]`

#### `routific.set_options( params )`

Sets optional options onto the route requests.
Optional arguments must be one of the following:

- `traffic`
- `min_visits_per_vehicle`
- `balance`
- `min_vehicles`
- `shortest_distance`
- `squash_duration`
- `max_vehicle_overtime`
- `max_visit_lateness`

#### `routific.get_route()`

Returns an optimized route using the previously provided visits, fleet and options.
The request may timeout if the problem is too large.

It returns a route object with the following attributes:
- `status`: A sanity check
- `unserved`: List of visits that could not be scheduled.
- `vehicle_routes`: The optimized schedule
- other attributes that you can find in the [full documentation](https://docs.routific.com)

The `vehicle_routes` attribute is a hash mapping vehicle ID to the corresponding route, represented as an array of waypoints: `{ "vehicle_1" => [ way_point_1, way_point_2, way_point_3, way_point_4 ] }`

The waypoint object has the following attributes:
- `location_id`
- `arrival_time`
- `finish_time`
- other attributes that you can find in the [full documentation](https://docs.routific.com)

#### `routific.get_route_async()`

For requests with 60 visits and more, it is recommended to make asynchronous call to the API.

```ruby
job = routific.get_route_async()
puts job.status # => "pending"
sleep 5
job.fetch
puts job.status # => "finished"
route = job.route
```

It returns a job object with the following attibutes:
- `status`: status of the task ('pending', 'processing', 'finished', 'error')
- `id`: a unique identifier for the task
- `created_at`, `finished_at`: creation and finish times
- `input`: the data used for the request
- `route`: a route object

#### `routific.set_project( data )`

Read the [platform documentation](https://routific-platform.readme.io/reference) for a full list of attributes.
