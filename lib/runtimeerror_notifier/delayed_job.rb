puts "setup Delayed::Worker"
::Delayed::Worker.lifecycle.around(:invoke_job) do |job, *args, &block|
  begin
    block.call(job, *args)
  rescue Exception => e
    ::RuntimeerrorNotifier::Notifier.notification({ job: job, args: args }, e)
    raise
  end
end
