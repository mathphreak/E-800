class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    @assignment = Assignment.new
  end

  def edit
    @assignment = Assignment.find(params[:id])
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to @assignment
    else
      render 'new'
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      redirect_to @assignment
    else
      render 'edit'
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    redirect_to assignments_path
  end

  private

  def assignment_params
    params
      .require(:assignment)
      .permit(:title, :description, :run_script)
      .transform_values do |x|
        if x.is_a?(String)
          x.encode(universal_newline: true)
        else
          x
        end
      end
  end
end
