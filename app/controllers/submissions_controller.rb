class SubmissionsController < ApplicationController
  def pending_index
    @assignments = Assignment.all
    @submissions = @assignments
      .map { |e| e.submissions }
      .flatten
      .select { |e| e.pending }
    respond_to do |format|
      format.html
      format.xml  { render xml: @submissions}
      format.json { render json: @submissions}
    end
  end

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
