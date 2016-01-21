# FIXME: I read somewhere that `require` is just bad in Rails
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
      .transform_values { |x| EnsureUniversalNewlines.fix x }
  end
end
