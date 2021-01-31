module RoutificApi
  # This class represents a job returned by vrp-long
  class Job
    FIELDS = [:status, :created_at, :finished_at]
    attr_reader *FIELDS
    attr_reader :input, :id, :route

    # Constructor
    def initialize(id, input)
      @id = id
      @input = input
      @status = 'pending'
    end

    def fetch
      job_data = Util.send_request("GET", "jobs/#{@id}")

      FIELDS.each do |field|
        instance_variable_set "@#{field}", job_data[field.to_s]
      end
      @route = RoutificApi::Route.parse(job_data["output"]) if job_data["output"]
      job_data['status']
    end
  end
end
