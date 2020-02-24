class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks
  end
  def show
    
  end
  def new
    @task = current_user.tasks.new
  end
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:sucsess] = "Task が正常に投稿されました"
      redirect_to root_url
    else
      flash.now[:danger] = "Task が投稿されませんでした"
      render :new
    end
  end
  def edit
    
  end
  def update
    if @task.update(task_params)
      flash[:sucsess] = "Task が正常に更新されました"
      redirect_to root_url
    else
      flash.now[:danger] = "Task が更新されませんでした"
      render :edit
    end
  end
  def destroy
    @task.destroy
    
    flash[:sucsess] = "Task が正常に削除されました"
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
    @user = User.find_by(id: @task.user_id)
    unless @user == current_user
      flash[:notice] = "権限がありません"
      redirect_to root_url
    end
  end
  
  #strong parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
