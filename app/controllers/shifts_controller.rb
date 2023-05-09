class ShiftsController < ApplicationController

before_action :logged_in_user, only: [:create, :destroy]

  def create
    @shift = current_user.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "Shift created!"
      redirect_to root_url
    else
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def shift_params
    params.require(:shift).permit(:otsutome_title)
  end

end




  # # フラッシュメッセージを Bootstrap 対応させるための設定
  # add_flash_types :success, :info, :warning, :danger

  # before_action :set_shift, only: %i[edit update destroy]

  # def index
  #   @shifts = Shift.all
  # end

  # def new
  #   @shift = Shift.new
  #   @default_date = params[:default_date].to_date
  # end

  # def create
  #   shift = Shift.new(shift_params)

  #   if Shift.save!
  #     redirect_to shifts_path, success: "シフトの登録に成功しました"
  #   else
  #     render :new
  #   end
  # end

  # def edit; end

  # def update
  #   if @Shift.update!(shift_params)
  #     redirect_to shifts_path, success: "シフトの更新に成功しました"
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @Shift.destroy

  #   redirect_to shifts_path, success: "シフトの削除に成功しました"
  # end

  # private

  #   def shift_params
  #     params.require(:shift).permit(:title, :start_time, :end_time)
  #   end

  #   def set_shift
  #     @shift = Shift.find(params[:id])
  #   end





