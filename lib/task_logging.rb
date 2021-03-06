module TaskLogging
  def task(*args, &block)
    Rake::Task.define_task(*args) do |task|
      if block_given?
        Rails.logger.debug "[#{task.name}] started"
        begin
          block.call(task)
          Rails.logger.debug "[#{task.name}] finished"
        rescue StandardError => e
          Rails.logger.debug "[#{task.name}] failed"
          raise e
        end
      end
    end
  end
end

extend TaskLogging
