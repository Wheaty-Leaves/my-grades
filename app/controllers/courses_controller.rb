class CoursesController < ApplicationController
  before_action :authenticate_teacher!, only: %i[new edit update destroy]
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    # if student_signed_in?
    #   @courses = Course.where(assessment_id: @assessment.id, student_id: current_user.id)
    # end
    c = Course.all
    puts "value of Course.all #{c.length}"
    @teachers = Array.new(@courses.length,nil)
    @courses.each_with_index do |c, i|
      temp = CourseTeacher.find_by course_id: c.id
      if temp != nil
        @teachers[i] = temp
      else
        #leave nil
      end
    end
  end

  # GET /courses/my_courses
  def my_courses
    if teacher_signed_in?
      teacher_courses = CourseTeacher.all.where teacher_id: current_user.id
      @courses = Array.new(teacher_courses.length,nil)
      teacher_courses.each_with_index do |c,i|
        @courses[i] = Course.find_by id: c.course_id
      end
    elsif student_signed_in?
      student_courses = Enrolment.all.where student_id: current_user.id
      @courses = Array.new(student_courses.length,nil)
      student_courses.each_with_index do |c,i|
        @courses[i] = Course.find_by id: c.course_id
      end
    end
    render 'courses/my_courses'
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course_teacher = CourseTeacher.find_by course_id: @course.id
    if not @course_teacher.nil?
      teacher = Teacher.find(@course_teacher.teacher_id)
      if not teacher.nil?
        @teacher_first_name = teacher.first_name
        @teacher_last_name = teacher.last_name
      end
    end
  end

  def claim_course
    CourseTeacher.create(teacher_id: current_teacher.id, course_id: params[:id])
    redirect_back(fallback_location: root_path)
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        # Creating the joining table for courses and teachers
        @course_id = @course.id
        @teacher_id = current_teacher.id
        @teacher_course = CourseTeacher.new(teacher_id: @teacher_id, course_id: @course_id)
        @teacher_course.save

        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name)
    end
end
