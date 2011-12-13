Dir[File.expand_path(File.dirname(__FILE__) + "/lib/*.rb")].each    { |f| require f }
puts File.expand_path(File.dirname(__FILE__) + "/../shared/*.rb")
Dir[File.expand_path(File.dirname(__FILE__) + "/../shared/*.rb")].each { |f| puts f; require f }

class Rspec
  attr_reader :auto_replace, :verbose

  def initialize(options)
    @auto_replace = options[:auto_replace]
    @verbose = options[:verbose]
  end

  def start
    everything_fine = false
    everything_fine = Equals.check_equals
    puts "Passed" if(everything_fine)
  end
end
