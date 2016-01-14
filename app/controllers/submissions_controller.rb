# I have no idea if this is the right way to do this
require_relative '../jobs/submissions_execute_job'

class SubmissionsController < ApplicationController
  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.create(submission_params)
    SubmissionsExecuteJob.perform_later @submission unless params[:dont_run]
    redirect_to assignment_path(@assignment)
  end

  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.find(params[:id])
    @submission.destroy
    redirect_to assignment_path(@assignment)
  end

  private

  def submission_params
    params
      .require(:submission)
      .permit(:author, :code)
      .transform_values do |x|
        if x.is_a?(String)
          x.encode(universal_newline: true)
        elsif x.is_a?(ActionDispatch::Http::UploadedFile)
          x.read.encode(universal_newline: true)
        else
          x
        end
      end
  end
end
