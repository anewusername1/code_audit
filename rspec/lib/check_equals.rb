class Equals
  def self.check_equals
    should_eq_eq = %x{find . -name '*_spec.rb' -exec grep -nE "(:?should|should_not) (:?==|!=)" /dev/null {} \\;}
    return true if(should_eq_eq == '')
    if(should_eq_eq)
      puts "\tYou're using \"==\" instead of \"eq()\""
      puts "\tThis is bad design."
      puts "\tWhat would you like to do?"
      puts "\t\t(r)eplace, r(e)view, (i)gnore, (q)uit"
      while(1)
        case ::UserInteraction.get_input
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
end
