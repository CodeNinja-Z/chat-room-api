# frozen_string_literal: true

require "spec_helper"
require "rails_helper"

RSpec.describe Comment, type: :model do
  subject { Comment.new }
  let(:forum) do
    Forum.create(title: "Pass the interview!",
                description: "Get competitive salary!")
  end
  let(:parent_comment) do 
    Comment.create(description: "This is a parent comment.",
                  forum: forum)
  end

  it "is valid with valid attributes" do
    subject.description = "She is a dentist."
    subject.forum = forum
    subject.parent_comment = parent_comment
    expect(subject).to be_valid
  end

  it "is valid without a parent comment" do
    subject.description = "She is a dentist."
    subject.forum = forum
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject.forum = forum
    expect(subject).to_not be_valid   
  end

  it "is not valid without a forum" do
    subject.description = "She is a dentist."
    expect(subject).to_not be_valid   
  end
end
