class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.rank(:order)
    @task = Task.new  # 新しいタスクを作成するフォーム用
    @preference_levels = PreferenceLevel.rank(:order)
    @time_slots = TimeSlot.rank(:order)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "業務が追加されました"
      redirect_to tasks_path
    else
      flash[:danger] = @task.errors.full_messages.join(", ")
      redirect_to tasks_path
    end
  end


  def destroy
    @task.destroy
    flash[:success] = "業務が削除されました"
    redirect_to tasks_path
  end

    # in preference_levels_controller.rb and time_slots_controller.rb
  def update_order
    params[:order].each_with_index do |id, index|
      Task.where(id: id).update_all(order: index + 1)
      # or TimeSlot.where(id: id).update_all(order: index + 1) for TimeSlotsController
    end
    head :ok  # this is a response to Ajax request
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end


  def set_task
    @task = Task.find(params[:id])
  end

end
