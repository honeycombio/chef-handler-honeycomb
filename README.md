# chef-handler-honeycomb

[![OSS Lifecycle](https://img.shields.io/osslifecycle/honeycombio/chef-handler-honeycomb)](https://github.com/honeycombio/home/blob/main/honeycomb-oss-lifecycle-and-practices.md)

Chef handler to report chef run statistics to Honeycomb

Steps to use this cookbook to report statistics to [Honeycomb](https://honeycomb.io)

* put your writekey in the attributes file, update dataset name if you wish
* add the cookbook *early* in the list (first is great)
* add the commented section from the recipes/default.rb to client.rb or other location
** See Chef's [config.rb documentation](https://docs.chef.io/config_rb_client.html)

run chef and see reports in Honeycomb!

If things don't work as you expect, you can add `-l debug` to the chef run. You
will see debug output which will include the HTTP POST to Honeycomb and its
results. Look for `DEBUG: Initiating POST` in the log. If you don't see
anything in Honeycomb, try using this flag and look to see whether Honeycomb is
responding with HTTP 200.
