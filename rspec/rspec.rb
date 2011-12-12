# TODO: check that we're in a git repository. Warn and prompt to continue if we aren't
# TODO: make this tell you when it found bad rspec code, what the code is, and prompt the user
# with options to (r)eplace, r(e)view, (o)verwrite, (i)gnore
# check_shoulds() {
  # ack "empty\?.should be_true"
  # ack "empty\?.should be_false"
  # ack "should != "
# }


Dir["./lib/*.rb"].each {|f| require f}
class Rspec
  attr_reader :auto_replace, :verbose

  def initialize(options)
    @auto_replace = options[:auto_replace]
    @verbose = options[:verbose]
  end

  def start
    everything_fine = false
    everything_fine = check_equals
    puts "Passed" if(everything_fine)
  end

  def check_equals
    should_eq_eq = %x{find . -name '*_spec.rb' -exec grep -nE "(:?should|should_not) (:?==|!=)" /dev/null {} \\;}
    return true if(should_eq_eq == '')
    if(should_eq_eq)
      puts "\tYou're using \"==\" instead of \"eq()\""
      puts "\tThis is bad design."
      puts "\tWhat would you like to do?"
      puts "\t\t(r)eplace, r(e)view, (i)gnore, (q)uit"
      while(1)
        case get_input
        when 'r'
          # replace should == and should !=
          `find . -name '*_spec.rb' -exec perl -pi -e 's/should ==[\s]+(.*)/should eq\($1\)/g' {} \\;`
          `find . -name '*_spec.rb' -exec perl -pi -e 's/should !=[\s]+(.*)/should_not eq\($1\)/g' {} \\;`

          # replace should_not == and should_not != (don't know why you'd do
          # that...)
          `find . -name '*_spec.rb' -exec perl -pi -e 's/should_not ==[\s]+(.*)/should_not eq\($1\)/g' {} \\;`
          `find . -name '*_spec.rb' -exec perl -pi -e 's/should_not !=[\s]+(.*)/should eq\($1\)/g' {} \\;`
          break
        when 'e'
          puts should_eq_eq
        when 'i'
          break
        end
      end
    end
    return false
  end

  def get_input
    user_input = gets
    case user_input
    when /r/
      return 'r'
    when /e/
      return 'e'
    when /i/
      return 'i'
    when /q/
      exit 0
    end
  end
end
