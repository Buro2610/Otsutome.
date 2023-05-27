class PreferenceLevelsController < ApplicationController
  def edit
    @preference_levels = PreferenceLevel.all
  end
end
