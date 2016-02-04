Routific Ruby Gem
=================

[![Build Status](https://secure.travis-ci.org/asoesilo/routific-gem.png)](http://travis-ci.org/asoesilo/routific-gem)

This Ruby Gem assists users to easily access the [Routific API][1], which is a practical and scalable solution to the Vehicle Routing Problem.

  [1]: https://routific.com/developers

Installing
----------

`gem install routific`

Usage
-----
Remember to require it and instantiate it with your token before using it

```ruby
require 'routific'
routific = Routific.new("INSERT API KEY")
```

### Instance methods

`routific.setVisit( id, [params] )`

Sets a visit for the specified location using the specified parameters

Required arguments in params:

- location: Object representing the location of the visit.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location

Optional arguments in params:

 - start: the earliest time for this visit. Default value is 00:00, if not specified.
 - end: the latest time for this visit. Default value is    23:59, if not specified.
 - duration: the length of this visit in minutes
 - demand: the capacity that this visit requires

`routific.setVehicle( id, params )`

Sets a vehicle with the specified ID and parameters

Required arguments in params:

- start_location: Object representing the start location for this vehicle.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location

Optional arguments in params:

 - end_location: Object representing the end location for this vehicle.
  + lat: Latitude of this location
  + lng: Longitude of this location
  + name: (optional) Name of the location

 - shift_start: this vehicle's start shift time (e.g. '08:00'). Default value is 00:00, if not specified.
 - shift_end: this vehicle's end shift time (e.g. '17:00'). Default value is 23:59, if not specified.
 - capacity: the capacity that this vehicle can load

`routific.getRoute()`

Returns the route using the previously provided network, visits and fleet information


### Class methods

`Routific.setToken( token )`

Sets the default access token to use

`Routific.setRaiseOnException( boolean )`

Sets whether errors in the Api request and response parsing should throw exceptions or fail silently. Defaults to false.

`Routific.setLogRequests( logger )`

Sets the ruby Logger to be used to log errors, request logs etc. If no logger is explicitly set, logs are sent to STDOUT

`Routific.setLogRequests( boolean )`

Sets whether the result of requests should be logged. Defaults to false.

`Routific.getRoute( id, [params] )`

Returns the route using the specified access token, network, visits and fleet information


Both getRoute functions return the Route object, which has the following attributes:

 - status: A sanity check, will always be success when the HTTP code is 200
 - fitness: Total travel-time, representing the fitness score of the solution (less is better)
 - unserved: List of visits that could not be scheduled.
 - vehicleRoutes: The optimized schedule

Examples
--------
Example 1:

```ruby
require 'routific'

routific = Routific.new("INSERT API KEY")

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

route = routific.getRoute()
```

Example 2:

```ruby
require 'routific'

Routific.setToken("INSERT API KEY")

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

data = {
  visits: visits,
  fleet: fleet
}

route = Routific.getRoute(data)
```
