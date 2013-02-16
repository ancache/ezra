# == Schema Information
#
# Table name: features
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string(255)
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ftype        :integer
#

require 'spec_helper'

describe Feature do
  let(:user) { FactoryGirl.create(:user) }
  before { @feature = user.features.build(name: "test feature",
                                   instructions: "test feature instructions",
                                          ftype: 0,
                                          fvalues: [true,false] ) }
  subject { @feature }

  it { should respond_to(:name) }
  it { should respond_to(:instructions) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:ftype) }
  it { should respond_to(:fvalues) }

  its(:user) { should == user }

  it { should respond_to(:targets) }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @feature.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Feature.new(user_id: user.id)
      end.to raise_error (ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "with blank name" do
    before { @feature.name = " " }
    it { should_not be_valid }
    end
  
  describe "with name that is too short" do
    before { @feature.name = 'a'*3 }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @feature.name = "z" * 26 }
    it { should_not be_valid }
  end

  describe "with blank instructions" do
    before { @feature.instructions = " " }
    it { should_not be_valid }
  end

  describe "with blank ftype" do
    before { @feature.ftype = nil }
    it { should_not be_valid } 
  end

  describe "with non-integer ftype" do
    before { @feature.ftype = 1.1 }
    it { should_not be_valid }
  end

  describe "with ftype greater than 3" do
    before { @feature.ftype = 4 }
    it { should_not be_valid }
  end
 
  describe "with ftype less than 0" do
    before { @feature.ftype = -1 }
    it { should_not be_valid }
  end
  
  describe "when fvalues is not present" do
    before { @feature.fvalues = nil }
    it { should_not be_valid }
  end

end
