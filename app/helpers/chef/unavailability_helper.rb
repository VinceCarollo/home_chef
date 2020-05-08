module Chef::UnavailabilityHelper
  def unavail_string_generator(weekday_choices)
    # For new chef form
    # Creates strings from form checkboxes 
    # chef.unavailable = 'mon, tue, wed'
    # input = {"monday"=>"0", "tuesday"=>"1", ...} | 0 = unavailable
    Date::DAYNAMES.map(&:downcase).map do |day|
      day[0..2] if weekday_choices[day.to_sym] == '0'
    end.compact.join(', ')
  end

  def unavail_to_readable(chef_unavail)
    # For Chef Dashboard
    readable_days = []
    Date::DAYNAMES.each do |day|
      chef_unavail.split(', ').each do |unavail_day|
        if day.downcase[0..2] == unavail_day
          readable_days << day
        end
      end
    end
    readable_days.join(', ')
  end
end