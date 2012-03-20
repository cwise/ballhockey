require 'spec_helper'

describe PlayersController do
  before(:each) do
    session
    session[:password] ||= 'playhockey'
    @params=valid_attributes
  end
  
  def valid_attributes
    Factory.build(:player).attributes
  end
    
  describe "GET index" do
    it "assigns all player to @players" do
      player = Factory(:player)
      get :index
      assigns(:players).should eq([player])
    end
    
    it "should render successfully" do
      player = Factory(:player)
      get :index
      response.should be_success
    end    
  end
  
  describe "GET summary" do
    it "assigns all player to @players" do
      player=Factory(:player)
      get :summary
      assigns(:players).should eq([player])
    end
    
    it "should render successfully" do
      player=Factory(:player)
      get :summary
      response.should be_success
    end    
  end  
  
  describe "GET on deck" do
    it "assigns all player to @players" do
      player=Factory(:player)
      get :on_deck
      assigns(:players).should eq([player])
    end
    
    it "should render successfully" do
      player=Factory(:player)
      get :on_deck
      response.should be_success
    end    
  end  
  
  describe "GET new" do
    it "assigns player to @player" do
      get :new
      assigns(:player).should be_true
    end    
    
    it "should render successfully" do
      get :new
      response.should be_success
    end    
  end
  
  describe "POST create" do
    it "should create player" do
      @_before = Player.count
      post :create, :player => @params
      assigns(:player).should_not be_new_record
      Player.count.should == (@_before + 1)
    end    
    
    it "should render successfully" do
      post :create, :player => @params
      response.should be_redirect
    end    
  end  
  
  describe "GET edit" do
    before(:each) do
      @player=Factory(:player)
    end
        
    it "assigns player to @player" do
      get :edit, :id => @player.id
      assigns(:player).should be_true
    end    
    
    it "should render successfully" do
      get :edit, :id => @player.id
      response.should be_success
    end    
  end
  
  describe "PUT update" do
    before(:each) do
      @player=Factory(:player)
    end
    
    it "should update player" do
      @_before = Player.count
      post :update, :id => @player.id, :player => @player.attributes
      Player.count.should == (@_before)
    end    
    
    it "should render successfully" do
      put :update, :id => @player.id, :player => @player.attributes
      response.should be_redirect
    end    
  end  
end
