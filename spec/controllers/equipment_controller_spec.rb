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
      equipment = Factory(:equipment)
      get :index
      assigns(:equipment).should eq([equipment])
    end
    
    it "should render successfully" do
      equipment = Factory(:equipment)
      get :index
      response.should be_success
    end    
  end
  
  describe "GET new" do
    it "assigns equipment to @equipment" do
      get :index
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
end
