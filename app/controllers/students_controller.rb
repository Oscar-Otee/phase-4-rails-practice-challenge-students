class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
def index
    students = Student.all
    render json: students, status: :ok
end

def show
    student = find_student
    render json: student, status: :ok
end

def create
    student = Student.create!(student_params)
    render json: student, status: :created
end

def update
    student = find_student
    student.update(student_params)
    render json: student, status: :ok
  end

def destroy
    student = find_student
    student.destroy
    render json: {}, status: :no_content
end

private
def student_params
    params.permit(:name, :age, :major, :instructor_id)
end

def find_student
    Student.find_by!(id: params[:id])
end

def render_not_found_response
    render json: {error: "Student not found"}
end

def unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end
end
