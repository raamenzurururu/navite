class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])
  end 

  def show
    @comment = Comment.new(task_id: @task.id)
  end

  def new
    @task = Task.new(flash[:task])
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "質問「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end 

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "質問「#{@task.name}」を更新しました。"
  end 

  def destroy
    @task.destroy
  end 

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end 

  private

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end 

  def set_task
    @task = current_user.tasks.find(params[:id])
  end 
end
