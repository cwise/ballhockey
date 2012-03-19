class EquipmentController < ApplicationController
  before_filter :admin_required
  
  def index
    @equipment=Equipment.order('description').all
  end

  def new
    @equipment=Equipment.new(params[:equipment])
  end
  
  def create
    @equipment=Equipment.new(params[:equipment])

    respond_to do |format|
      if @equipment.save
        flash[:notice]='Equipment add succeeded'
        format.html { redirect_to equipment_index_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @equipment=Equipment.find(params[:id])
    
  end
  
  def update
    @equipment=Equipment.find(params[:id])
    @equipment.attributes=params[:equipment]
    
    respond_to do |format|
      if @equipment.save
        flash[:notice]='Equipment update succeeded'
        format.html { redirect_to equipment_index_path }
      else
        flash[:notice] = 'Equipment update failed'
        format.html { render :action => 'edit' }        
      end
    end
  end

  def destroy
    @equipment=Equipment.find(params[:id])
    @equipment.delete
    flash[:alert]="Successfully deleted #{@equipment.description}"
    redirect_to equipment_index_path
  end
end
