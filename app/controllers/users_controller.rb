class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.includes(:micro_posts => :task).paginate(page: params[:page])
    @users.each do |user|
      user.micro_posts.sort_by! { |mp| mp.task.order }
    end
  end

  def show
    @user = User.find(params[:id])
    @shifts = @user.shifts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Otsutome. へようこそ！ "
      redirect_to @user   #本当はuser_url(@user)
    else
      render 'new',status: :unprocessable_entity
    end
  end

  def edit
    @task_names = User.find_by(admin: true)&.tasks&.order(:order)&.pluck(:name)
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @task_names = User.find_by(admin: true)&.tasks&.pluck(:name)
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      flash[:danger] = "プロフィールの更新に失敗しました"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url, status: :see_other
  end





  private             #private注意！！！！※※※

      def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation, :position_title, possible_task:[])
      end

    # beforeフィルタ


    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end


     # 管理者かどうか確認
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end



end
