class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[show edit update destroy]

  def index
    @assignments = Assignment.all
  end

  def show; end

  def new
    @assignment = Assignment.new
    @courses = Course.all.pluck(:title, :id)
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to @assignment, notice: 'Assignment created successfully.'
    else
      render :new
    end
  end

  def edit
    @courses = Course.all.pluck(:title, :id)
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to @assignment, notice: 'Assignment updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: 'Assignment deleted successfully.'
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:title, :description, :course_id)
  end
end