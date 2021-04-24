require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "validations" do
    it { should validate_presence_of :city }
    it { should validate_numericality_of(:lat).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:lng).is_greater_than_or_equal_to(0) }
  end
  describe "class methods" do
    describe "::" do
      it "text" do

      end
    end
  end
  describe "instance methods" do
    describe "#" do
      it "text" do

      end
    end
  end
end
