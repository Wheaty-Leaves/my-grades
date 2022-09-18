class EnrolmentsController < ApplicationController
  before_action :authenticate_teacher!, only: %i[ new destroy]
  before_action :set_enrolment, only: %i[ destroy ]
  before_action :set_course, only: %i[ new index destroy ]
  before_action :get_unenrolled_students, only: %i[ new ]

  # GET /enrolments or /enrolments.json
  def index
    @enrolments = @course.enrolments.all
  end

  # GET /enrolments/new
  def new
    @course = Course.find( params[:course_id] )
    @enrolment = @course.enrolments.new
  end

  # POST /enrolments or /enrolments.json
  def create
    @course = Course.find(params[:course_id] )
    @enrolment = @course.enrolments.new(enrolment_params)

    respond_to do |format|
      if @enrolment.save
        format.html { redirect_to course_enrolments_url(@course), notice: "Enrolment was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrolment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrolments/1 or /enrolments/1.json
  def destroy
    @enrolment.destroy

    respond_to do |format|
      format.html { redirect_to course_enrolments_url(@course), notice: "Enrolment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrolment
      @enrolment = Enrolment.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def get_unenrolled_students
      course = Course.find(params[:course_id])
      enrolled_student_ids = course.enrolments.all.pluck(:student_id)
      @unenrolled_students = Student.where.not(id: enrolled_student_ids)
    end

    # Only allow a list of trusted parameters through.
    def enrolment_params
      params.require(:enrolment).permit(:student_id)
    end
end
