require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last name, email, and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end
    
  it "is invalid without a first name" do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without a email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "tester@example.com",
      password: "testerpassword",
    )
    user = User.new(
      first_name: "Jane",
      last_name: "Tester",
      email: "tester@example.com",
      password: "testerpassword",
    )
    user.valid?
    expect(user.errors[:email]).to  include("has already been taken")
  end

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    expect(user.name).to eq "John Doe"
  end
end
