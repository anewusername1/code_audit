class UserInteraction
  def self.get_input
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
