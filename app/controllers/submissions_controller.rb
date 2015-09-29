class SubmissionsController < ApplicationController
  def create
    @assignment = Assignment.find(params[:assignment_id])
    @submission = @assignment.submissions.create(submission_params)
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
      params.require(:submission).permit(:author, :code)
    end
end
