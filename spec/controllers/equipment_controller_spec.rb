require 'spec_helper'

describe EquipmentController do
  before(:each) do
    session
    session[:password] ||= 'playhockey'
    @params=valid_attributes
  end
  
  def valid_attributes
    Factory.build(:equipment).attributes
  end
    
  describe "GET index" do
    it "assigns all equipment to @equipment" do
      equipment=Factory(:equipment)
      get :index
      assigns(:equipment).should include(equipment)
    end
    
    it "should render successfully" do
      equipment = Factory(:equipment)
      get :index
      response.should be_success
    end    
  end
  
  describe "GET new" do
    it "assigns equipment to @equipment" do
      get :new
      assigns(:equipment).should be_true
    end    
    
    it "should render successfully" do
      get :new
      response.should be_success
    end    
  end
  
  describe "POST create" do
    it "should create equipment" do
      @_before = Equipment.count
      post :create, :equipment => @params
      assigns(:equipment).should_not be_new_record
      Equipment.count.should == (@_before + 1)
    end    
    
    it "should render successfully" do
      post :create, :equipment => @params
      response.should be_redirect
    end    
  end  
  
  describe "GET edit" do
    before(:each) do
      @equipment=Factory(:equipment)
    end
        
    it "assigns equipment to @equipment" do
      get :edit, :id => @equipment.id
      assigns(:equipment).should be_true
    end    
    
    it "should render successfully" do
      get :edit, :id => @equipment.id
      response.should be_success
    end    
  end
  
  describe "PUT update" do
    before(:each) do
      @equipment=Factory(:equipment)
    end
    
    it "should update equipment" do
      @_before = Equipment.count
      post :update, :id => @equipment.id, :equipment => @equipment.attributes
      Equipment.count.should == (@_before)
    end    
    
    it "should render successfully" do
      put :update, :id => @equipment.id, :equipment => @equipment.attributes
      response.should be_redirect
    end    
  end  
end
