class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_task, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    session[:sort] = params[:sort] || session[:sort] || ''
    @task  = current_user.tasks.new
    @tasks = current_user.tasks.reload
    @tasks = @tasks.order(session[:sort]) unless session[:sort].blank?
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def create
    @task = Task.new(params[:task])
    @task.user_id = current_user.id
    @task.save
    if @task.save
      redirect_to root_path(reset: true), notice: 'Task created successfully'
    else
      render action: 'new'
    end
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to root_path, notice: 'Task successfully updated'
    else 
      render action: 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task destroyed successfully'
  end

  def toggle
    @task.toggle!(:completed)
    redirect_to root_path, notice: 'Task successfully removed'
  end

  private
  def find_task
    @task = current_user.tasks.find(params[:id])
  end

end
