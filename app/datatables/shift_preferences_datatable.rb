class ShiftPreferencesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: ShiftPreference.count,
      iTotalDisplayRecords: shift_preferences.total_entries,
      aaData: data
    }
  end

private

  def data
    shift_preferences.map do |shift_preference|
      [
        shift_preference.user.name,
        shift_preference.time_slot.name,
        shift_preference.preference_level.name,
        shift_preference.start_time,
        shift_preference.end_time
      ]
    end
  end

  def shift_preferences
    @shift_preferences ||= fetch_shift_preferences
  end

  def fetch_shift_preferences
    shift_preferences = ShiftPreference.order("#{sort_column} #{sort_direction}")
    shift_preferences = shift_preferences.page(page).per_page(per_page)
    if params[:sSearch].present?
      shift_preferences = shift_preferences.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    shift_preferences
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[user.name time_slot.name preference_level.name start_time end_time]
    columns[params[:iSortCol_0].to_i]
  end


  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
