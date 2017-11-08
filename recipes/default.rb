Chef.event_handler do
  Chef::Client.when_run_completes_successfully {|run_status| @handler.instance_variable_set(:@run_status, run_status) }
  Chef::Client.when_run_fails {|run_status| @handler.instance_variable_set(:@run_status, run_status) }
  on :run_completed do
    ::Honeycomb.report(@run_status)
  end
  on :run_failed do
    ::Honeycomb.report(@run_status)
  end
end


  # By the time this recipe has been processed,
  # these handlers have already been triggered
  # so you can't add handlers anymore.
  # Copy and paste this section into your client.rb
  # or /etc/chef/client.d or /etc/chef/solo.d
  # depending on how you're running chef to get
  # them loaded early enough to get triggered
  #
  # Chef.event_handler do
  #   on :converge_start do
  #     ::Honeycomb.converge_start()
  #   end
  #   on :converge_complete do
  #     ::Honeycomb.converge_complete()
  #   end
  #   on :handlers_start do
  #     ::Honeycomb.handlers_start()
  #   end
  #   on :handlers_completed do
  #     ::Honeycomb.handlers_completed()
  #   end
  #   on :resource_update_applied do
  #     ::Honeycomb.resource_update_applied()
  #   end
  # end

