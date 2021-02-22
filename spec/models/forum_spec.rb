# frozen_string_literal: true

require "spec_helper"
require "rails_helper"

RSpec.describe Forum, type: :model do
  subject { Forum.new }

  it "is valid with valid attributes" do
    subject.title = "Pass the interview!"
    subject.description = "Get competitive salary!"
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.description = "Get competitive salary!"
    expect(subject).to_not be_valid   
  end

  it "is not valid without a description" do
    subject.title = "Pass the interview!"
    expect(subject).to_not be_valid   
  end
end
