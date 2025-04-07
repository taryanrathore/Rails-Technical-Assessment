class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[show edit update destroy]
  before_action :set_terms, only: %i[new edit create update]

  def index
    @courses = if params[:search].present?
      Course.where("title ILIKE ?", "%#{params[:search]}%")
    else
      Course.all
    end
    
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @assignments = @course.assignments.order(id: :desc)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit;
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Course deleted successfully.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_terms
    @terms = Term.all.pluck(:name, :id)
  end

  def course_params
    params.require(:course).permit(:title, :term_id, :status)
  end
end
