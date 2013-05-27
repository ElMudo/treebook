require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)
  
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end
  
  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end
  
  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:conor).profile_name
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Conor', last_name: 'Wyse', email: 'el.mudo@xs4all.nl')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = "My profile with spaces"
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end
  
  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Conor', last_name: 'Wyse', email: 'el.mudo@xs4all.nl')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = 'conor_12345'
    assert user.valid?
  end
  
  test "that no error is raised when trying to access a user's friends" do
    assert_nothing_raised do
      users(:conor).friends
    end
  end
  
  test "that creatomg friendships on a user works" do
    users(:conor).friends << users(:mike)
    users(:conor).friends.reload
    assert users(:conor).friends.include?(users(:mike))
  end
  
  test "that creatomg a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:conor).id, friend_id: users(:mike).id
    assert users(:conor).friends.include?(users(:mike))
  end
  
  test "that calling to_param on a user returns the profile_name" do
    assert_equal "basketcase", users(:conor).to_param
  end
end
