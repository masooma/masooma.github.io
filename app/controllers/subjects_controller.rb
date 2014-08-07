class SubjectsController < ApplicationController

  layout false

  def index
    @subject = Subject.order("position ASC") 
    # we cal also define it as a scope in subjects controller like:
    # scope :sorted, lambda {order(subjects.position ASC)}
    # and call sorted here like: @subject = Subject.sorted
  end

  def new
    @subject = Subject.new
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)
        flash[:notice] = "Subject updated successfully"
        redirect_to(:action => 'show', :id => @subject.id)
    else
        render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' deleted successfully"
    redirect_to(:action => 'index')
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  private 

      def subject_params
        params.require(:subject).permit(:name, :position, :visible)
      end
end
