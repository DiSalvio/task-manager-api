module V1
  class TasksController < ApplicationController
    before_action :set_bucket
    before_action :set_task, only: [:show, :update, :destroy]

    def index
      json_response(@bucket.tasks)
    end

    def show
      json_response(@task)
    end

    def create
      @bucket.tasks.create!(task_params)
      json_response(@bucket, :created)
    end

    def update
      @task.update(task_params)
      head :no_content
    end

    def destroy
      @task.destroy
      head :no_content
    end

    private

    def task_params
      params.permit(:title, :status, :description, :started_on, :complete_by)
    end

    def set_bucket
      @bucket = Bucket.find(params[:bucket_id])
    end

    def set_task
      @task = @bucket.tasks.find_by!(id: params[:id]) if @bucket
    end
  end
end
