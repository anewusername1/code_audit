Dir[File.expand_path(File.dirname(__FILE__) + "/lib/*.rb")].each       { |f| require f }
Dir[File.expand_path(File.dirname(__FILE__) + "/../shared/*.rb")].each { |f| require f }

class Rspec
  attr_reader :auto_replace, :verbose, :pass_or_fail

  def initialize(options)
    @auto_replace = options[:auto_replace]
    @verbose = options[:verbose]
    @pass_or_fail = options[:pass_or_fail]
  end

  def start
    everything_fine = false
    everything_fine = Equals.check_equals(pass_or_fail)
    if(pass_or_fail && everything_fine)
      puts "Pass"
    elsif(pass_or_fail && !everything_fine)
      puts "Fail"
    end
  end
end
