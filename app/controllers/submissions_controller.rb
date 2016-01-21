# FIXME: I read somewhere that `require` is just bad in Rails
require_relative '../jobs/submissions_execute_job'

class SubmissionsController < ApplicationController
  def create
    read_data_params
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
      .permit(:author, submitted_files_attributes: [:data, :file_spec_id])
      .transform_values { |x| EnsureUniversalNewlines.fix x }
  end

  def read_data_params
    sfattributes = params[:submission][:submitted_files_attributes]
    return unless sfattributes
    sfattributes.each do |x|
      idx = x[0]
      file = x[1]
      sfattributes[idx][:data] = EnsureUniversalNewlines.fix file[:data].read
    end
  end
end
