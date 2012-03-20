require 'spec_helper'

describe GamesController do
  before(:each) do
    session
    session[:password] ||= 'playhockey'
    @params=valid_attributes
  end
  
  def valid_attributes
    Factory.build(:game).attributes
  end
    
  describe "GET index" do
    it "assigns all games to @games" do
      game=Factory(:game)
      get :index
      assigns(:games).should eq([game])
    end
    
    it "should render successfully" do
      game=Factory(:game)
      get :index
      response.should be_success
    end    
  end
  
  describe "GET new" do
    it "assigns game to @game" do
      get :new
      assigns(:game).should be_true
    end    
    
    it "should render successfully" do
      get :new
      response.should be_success
    end    
  end
  
  describe "POST create" do
    it "should create game" do
      @_before = Game.count
      post :create, :game => @params
      assigns(:game).should_not be_new_record
      Game.count.should == (@_before + 1)
    end    
    
    it "should render successfully" do
      post :create, :game => @params
      response.should be_redirect
    end    
  end  
  
  describe "GET edit" do
    before(:each) do
      @game=Factory(:game)
    end
        
    it "assigns game to @game" do
      get :edit, :id => @game.id
      assigns(:game).should be_true
    end    
    
    it "should render successfully" do
      get :edit, :id => @game.id
      response.should be_success
    end    
  end
  
  describe "PUT update" do
    before(:each) do
      @game=Factory(:game)
    end
    
    it "should update game" do
      @_before = Game.count
      post :update, :id => @game.id, :game => @game.attributes
      Game.count.should == (@_before)
    end    
    
    it "should render successfully" do
      put :update, :id => @game.id, :game => @game.attributes
      response.should be_redirect
    end    
  end  
end
