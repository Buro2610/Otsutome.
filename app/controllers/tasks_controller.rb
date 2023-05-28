class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
    @task = Task.new  # 新しいタスクを作成するフォーム用
    @preference_levels = PreferenceLevel.all
    @time_slots = TimeSlot.all
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

  private

  def task_params
    params.require(:task).permit(:name)
  end


  def set_task
    @task = Task.find(params[:id])
  end

end
