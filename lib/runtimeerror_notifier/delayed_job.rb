::Delayed::Worker.lifecycle.around(:invoke_job) do |job, *args, &block|
  begin
    block.call(job, *args)
  rescue Exception => e
    ::RuntimeerrorNotifier::Notifier.notification({ 'job' => job.attributes, 'args' => args }, e)
    raise
  end
end
