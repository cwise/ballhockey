class EquipmentController < ApplicationController
  def index
    @equipment=Equipment.all
  end

  def new
    @equipment=Equipment.new(params[:equipment])

    if request.post? and @equipment.save
        flash[:notice] = 'Equipment add succeeded'
        redirect_to({:action => 'index'})
    else
      #use the same form for editting
      render :action => 'edit'
    end
  end

  def edit
    @equipment=Equipment.find(params[:id])
    if request.post?
      @equipment.attributes=params[:equipment]
      if @equipment.save
        flash[:notice] = 'Equipment update succeeded'
        redirect_to({:action => 'index'})
      else
        flash[:notice] = 'Equipment update failed'
      end
    end
  end

  def delete
    @equipment=Equipment.find(params[:id])
    @equipment.delete
    redirect_to :back
  end
end
