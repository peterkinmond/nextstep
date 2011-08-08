# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

require 'spec_helper'

describe User do
  
  before(:each) do
     @attr = {
       :name => "Sample User",
       :email => "me@example.com",
       :password => "underworld", 
       :password_confirmation => "underworld"
     }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end   
  
  it "should require a name" do
     no_name_user = User.new(@attr.merge(:name => ""))
     no_name_user.should_not be_valid
  end 
  
  it "should require an email" do
     no_name_user = User.new(@attr.merge(:email => ""))
     no_name_user.should_not be_valid
  end 
  
  it "should reject names that are too long" do
     long_name = "a" * 51
     long_name_user = User.new(@attr.merge(:name => long_name))
     long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
     addresses = %w[user@foo,com THE_USER_atfoo.bar.org first.last@foo.]
     addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
     end
  end

  it "should reject duplicate email addresses" do
     User.create!(@attr)
     user_with_dup_email = User.new(@attr)
     user_with_dup_email.should_not be_valid
  end

  it "should reject email addresses what are same except for case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr)
    user_with_dup_email = User.new(@attr.merge(:email => upcased_email))
    user_with_dup_email.should_not be_valid
  end
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
       @user.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
       @user.should respond_to(:password_confirmation)
    end
  end  
  
  describe "password validations" do
     it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
     end
    
  end
end
