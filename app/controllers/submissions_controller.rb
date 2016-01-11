# I have no idea if this is the right way to do this
require_relative '../jobs/submissions_execute_job'

class SubmissionsController < ApplicationController
  def pending_index
    @assignments = Assignment.all
    @submissions = @assignments
                   .map(&:submissions)
                   .flatten
                   .select(&:pending)
    respond_to do |format|
      format.html
      format.xml  { render xml: @submissions }
      format.json { render json: @submissions }
    end
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.create(submission_params)
    SubmissionsExecuteJob.perform_later @submission
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
        else
          x
        end
      end
  end
end
