class MyWorker < ApplicationJob
  queue_as :default

  def perform(name)
    puts "Hello, #{name}! Your background job is running..."
  end
end
