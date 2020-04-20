module Chef::UnavailabilityHelper
  def unavail_string_generator(weekday_choices)
    # Creates strings from form checkboxes 
    # chef.unavailable = 'mon, tue, wed'
    # input = {"monday"=>"0", "tuesday"=>"1", ...} | 0 = unavailable
    binding.pry
    Date::DAYNAMES.map(&:downcase).map do |day|
      day[0..2] if weekday_choices[day.to_sym] == '0'
    end.compact.join(', ')
  end
end