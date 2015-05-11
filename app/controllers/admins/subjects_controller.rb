class Admins::SubjectsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_subject, except: [:index, :new, :create]
  
  def index
    @subjects = Subject.paginate page: params[:page], per_page: 15
  end
  
  def show
  end
  
  def new
    @subject = Subject.new
  end
  
  def create
    @subject = Subject.new subject_params
    if @subject.save
      redirect_to admins_subjects_path, success: t(:created_success, model: "subject")
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    if @subject.update_attributes subject_params
      redirect_to admins_subjects_path, success: t(:updated_success, model: "subject")
    else
      render "edit"
    end
  end
  
  def destroy
    @subject.destroy
    redirect_to admins_subjects_path, success: t(:delete_success, model: "subject")
  end
  
  private
  def set_subject
    @subject = Subject.find params[:id]
  end
  
  def subject_params
    params.require(:subject).permit :name, :duration
  end
end
