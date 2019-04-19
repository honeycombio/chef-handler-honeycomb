require "chef/http/simple_json"
require "time"

VERSION="0.1.1"

class Honeycomb
  class << self
    attr_accessor :converge_start,
                  :converge_duration,
                  :handlers_start,
                  :handlers_duration,
                  :num_resources_modified

    def num_resources_modified
      @num_resources_modified ||= 0
    end

    def converge_started
      self.converge_start = Time.now
    end

    def converge_completed
      if converge_start
        self.converge_duration = Time.now - converge_start
      end
    end

    def handlers_started
      self.handlers_start = Time.now
    end

    def handlers_completed
      if handlers_start
        self.handlers_duration = Time.now - handlers_start
      end
    end

    def resource_update_applied
      self.num_resources_modified += 1
    end

    def report(run_status)
      url = run_status.node['honeycomb']['api_url']
      path = "/1/events/#{run_status.node['honeycomb']['dataset']}"
      headers = {
        "X-Honeycomb-Team" => run_status.node['honeycomb']['writekey'],
        "X-Event-Time" => run_status.start_time.iso8601,
      }
      api_data = {
        "node.name" => run_status.node.name,
        "start_time" => run_status.start_time,
        "end_time" => run_status.end_time,
        "elapsed_time" => run_status.elapsed_time,
        "success" => run_status.success?,
        "exception" => run_status.exception,
        "backtrace" => run_status.backtrace,
        "run_id" => run_status.run_id,
        "updated_resources" => run_status.updated_resources,
        "converge_duration" => converge_duration,
        "converge_start" => converge_start,
        "handlers_duration" => handlers_duration,
        "handlers_start" => handlers_start,
        "num_resources_modified" => num_resources_modified,
        "run_list" => run_status.node.run_list.to_s,
      }
      Chef::Log.debug "about to submit api data #{api_data}"
      Chef::HTTP::SimpleJSON.new(url).post(path, api_data, headers)
    end
  end
end
