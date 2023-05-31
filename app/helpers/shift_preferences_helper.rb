module ShiftPreferencesHelper
  def percentage_of_time_range(start_time, end_time, range_start, range_end)
    total_minutes = ((range_end.in_time_zone("Tokyo") - range_start.in_time_zone("Tokyo")) / 60) % (24 * 60)
    duration_minutes = ((end_time.in_time_zone("Tokyo") - start_time.in_time_zone("Tokyo")) / 60) % (24 * 60)
    (duration_minutes / total_minutes * 100).round(2)
  end

  def percentage_of_day_for_time_in_range(time, range_start, range_end)
    total_minutes = ((range_end.in_time_zone("Tokyo") - range_start.in_time_zone("Tokyo")) / 60) % (24 * 60)
    minutes_since_start = ((time.in_time_zone("Tokyo") - range_start.in_time_zone("Tokyo")) / 60) % (24 * 60)
    (minutes_since_start / total_minutes * 100).round(2)
  end


  def percentage_of_time_range(start_time, end_time, range_start, range_end)
    total_minutes = ((range_end - range_start) / 60) % (24 * 60)
    duration_minutes = ((end_time - start_time) / 60) % (24 * 60)
    (duration_minutes / total_minutes * 100).round(2)
  end

  def percentage_of_day_for_time_in_range(time, range_start, range_end)
    total_minutes = ((range_end - range_start) / 60) % (24 * 60)
    minutes_since_start = ((time - range_start) / 60) % (24 * 60)
    (minutes_since_start / total_minutes * 100).round(2)
  end

  def has_possible_task?(user, date)
    user.shifts.where('DATE(start_time) <= :date AND DATE(end_time) >= :date', date: date).any? do |shift|
      user.possible_task.include?(shift.otsutome_title)
    end
  end

end
