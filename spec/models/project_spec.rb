require 'rails_helper'

RSpec.describe Project, type: :model do

  it "is invalid without a name" do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end


  it "does not allow duplicate projects names per user" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester@example.com",
      password: "testerpassword",
    )

    user.projects.create(
      name: "Test project",
    )

    new_project = user.projects.new(
      name: "Test project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allow two users to share a project name" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "testerpassword",
    )
    user.projects.create(
      name: "Test project",
    )
    other_user = User.create(
      first_name: "Jane",
      last_name: "Tester",
      email: "janetester@example.com",
      password: "testerpassword",
    )
    other_project = other_user.projects.new(
      name: "Test project",
    )
    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end
    it "is on time when the due date is today" do
      project = FactoryBot.create(:project_due_today)
      expect(project).to_not be_late
    end
    it "is late when the due date is in the future" do
      project = FactoryBot.create(:project_due_tomorrow)
      expect(project).to_not be_late
    end
  end
end
