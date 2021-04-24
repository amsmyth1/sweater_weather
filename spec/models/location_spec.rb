require 'rails_helper'

RSpec.descsribe Location, type: :model do
  describe "validations" do
    it { should validate_presence_of :city }
    it { should validate_numericality_of(:lan).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:lng).is_greater_than_or_equal_to(0) }
  end
  descsribe "class methods" do
    descsribe "::" do
      it "text" do

      end
    end
  end
  descsribe "instance methods" do
    descsribe "#" do
      it "text" do

      end
    end
  end
end
