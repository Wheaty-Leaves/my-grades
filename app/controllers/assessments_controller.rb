class AssessmentsController < ApplicationController
  before_action :set_enrolment, only: %i[ show destroy ]
  before_action :set_course, only: %i[ new show index destroy ]
  before_action :set_assessment, only: %i[ show edit update destroy ]
  before_action :set_course, only: %i[ new index destroy ]

  # GET /assessments or /assessments.json
  def index
    if student_signed_in?
      @grades = Grade.where(course_id: @course.id, student_id: current_user.id)
    end
    @assessments = Assessment.all.where course_id: params[:course_id]

  end

  # GET /assessments/1 or /assessments/1.json
  def show
    if student_signed_in?
      @grades = Grade.where(assessment_id: @assessment.id, student_id: current_user.id)
    elsif teacher_signed_in?
      @grades = Grade.all.where(assessment_id: @assessment.id)
    end
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments or /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to assessment_url(@assessment), notice: "Assessment was successfully created." }
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessments/1 or /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to assessment_url(@assessment), notice: "Assessment was successfully updated." }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1 or /assessments/1.json
  def destroy
    @assessment.destroy

    respond_to do |format|
      format.html { redirect_to course_assessments_url(@course), notice: "Assessment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_enrolment
      if not params[:enrolment_id].nil?
        @enrolment = Enrolment.find(params[:enrolment_id])
      end
    end

    # Only allow a list of trusted parameters through.
    def assessment_params
      params.require(:assessment).permit(:name, :total, :due_date, :release_date)
    end
end
