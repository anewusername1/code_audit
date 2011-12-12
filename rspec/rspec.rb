Dir["./lib/*.rb"].each {|f| require f}
class Rspec
  attr_reader :auto_replace, :verbose

  def initialize(options)
    @auto_replace = options[:auto_replace]
    @verbose = options[:verbose]
  end

  def start
    check_equals
  end

  def check_equals
    should_eq_eq = %x{find . -name '*_spec.rb' -exec grep -n "should ==" /dev/null {} \\;}
    return 0
    if(should_eq_eq)
      puts "\tYou're using \"should ==\" instead of \"should eq()\""
      puts "\tThis is bad design."
      puts "\tWhat would you like to do?"
      puts "\t\t(r)eplace, r(e)view, (i)gnore, (q)uit"
      while(1)
        case get_input
        when 'r'
          `find . -name '*_spec.rb' -exec perl -pi -e 's/should ==[\s]+(.*)/should eq\($1\)/g' {} \;`
        when 'e'
          puts should_eq_eq
        when 'i'
          break
        end
      end
    end
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
