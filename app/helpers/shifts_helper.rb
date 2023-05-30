module ShiftsHelper
  def shift_on_date?(user, date)
    user.shifts.where('DATE(start_time) <= :date AND DATE(end_time) >= :date', date: date).exists?
  end

  def shift_during_timeslot?(user, date, time_slot)
    user.shifts.where('DATE(start_time) <= :date AND DATE(end_time) >= :date', date: date).each do |shift|
      shift_start = shift.start_time.strftime("%H:%M").to_time
      shift_end = shift.end_time.strftime("%H:%M").to_time
      timeslot_start = time_slot.start_time.strftime("%H:%M").to_time
      timeslot_end = time_slot.end_time.strftime("%H:%M").to_time

      return true if shift_start <= timeslot_end && shift_end >= timeslot_start
    end
    false
  end
end

