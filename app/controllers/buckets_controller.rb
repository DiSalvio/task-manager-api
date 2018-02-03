class BucketsController < ApplicationController
  before_action :set_bucket, only: [:show, :update, :destroy]

  def index
    @buckets = current_user.buckets
    json_response(@buckets)
  end

  def create
    @bucket = current_user.buckets.create!(bucket_params)
    json_response(@bucket, :created)
  end

  def show
    json_response(@bucket)
  end

  def update
    @bucket.update(bucket_params)
    head :no_content
  end

  def destroy
    @bucket.destroy
    head :no_content
  end
  
  private

  def bucket_params
    # whitelist params
    params.permit(:title, :description, :started_on, :complete_by)
  end

  def set_bucket
    @bucket = Bucket.find(params[:id])
  end
end
