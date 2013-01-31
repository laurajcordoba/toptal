class Api::TasksController < ApplicationController
  before_filter :http_basic_authentication
  before_filter :find_task, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @tasks = Task.all
    respond_with @tasks
  end

  def show
    respond_with @task
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      respond_with(@task, location: api_task_path(@task))
    else
      respond_with(@task)
    end
  end

  def update
    @task.update_attributes(params[:task])
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private

  def find_task
    @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "The task you were looking for could not be found" }
      render json: error, status: 404
  end
end