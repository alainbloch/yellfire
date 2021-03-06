require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def new_user(attributes = {})
    attributes[:name] ||= 'Alain Bloch'
    attributes[:name] ||= 'alainbloch'
    attributes[:email] ||= 'alainbloch@gmail.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    user = User.new(attributes)
    user.valid? # run validations
    user
  end
  
  context "a user instance" do
    should_have_many :followers
    should_have_many :followings
    should_have_many :users_followed
    should_have_many :follows
    should_have_many :messages
    should_not_allow_mass_assignment_of :password_hash, :password_salt
  end
  
  context "a new user" do
  
    setup do
      User.delete_all
    end
  
    should "have valid new user" do
      assert new_user.valid?
    end
  
    should "not be valid if bio is too long" do
      long_bio = Faker::Lorem.paragraphs(2).to_s
      assert(new_user(:bio => long_bio).errors.on(:bio))
    end
  
    should "not be valid if full name is too long" do
      long_name = Faker::Lorem.paragraph
      assert(new_user(:name => long_name).errors.on(:name))
    end
  
    should "require a full name" do
      assert new_user(:name => '').errors.on(:name)
    end
  
    should "require a name" do
      assert new_user(:name => '').errors.on(:name)
    end
  
    should "require a password" do
      assert new_user(:password => '').errors.on(:password)
    end
  
    should "not be valid if email is not correct" do
      assert new_user(:email => 'foo@bar@example.com').errors.on(:email)
    end
  
    should "not be valid if email is not unique" do
      new_user(:email => 'bar@example.com').save!
      assert new_user(:email => 'bar@example.com').errors.on(:email)
    end
  
    should "not be valid if name is not unique" do
      new_user(:name => 'uniquename').save!
      assert new_user(:name => 'uniquename').errors.on(:name)
    end
  
    should "not be valid if name has odd characters" do
      assert new_user(:name => 'odd ^&(@)').errors.on(:name)
    end
  
    should "not be valid if password is too short" do
      assert new_user(:password => 'bad').errors.on(:password)
    end
  
    should "not be valid if password isn't confirmed" do
      assert new_user(:password_confirmation => 'nonmatching').errors.on(:password)
    end
  
    should "generate a password hash and salt upon creation" do
      user = new_user
      user.save!
      assert user.password_hash
      assert user.password_salt
    end
  
  end
  
  context "a created user" do
    
    setup do
      @user = new_user(:name => 'foobar', :password => 'secret', :email => 'foo@bar.com')
      @user.save!
      @user2 = users(:foo)
    end
    
    context "when authenticating" do
  
      should "authenticate by name" do
        assert_equal @user, User.authenticate('foobar', 'secret')
      end
  
      should "authenticate by email" do
        assert_equal @user, User.authenticate('foo@bar.com', 'secret')
      end
  
      should "not authenticate with a bad name" do
        assert_nil User.authenticate('nonexisting', 'secret')
      end
  
      should "not authenticate with a bad password" do
        assert_nil User.authenticate('foobar', 'badpassword')
      end
      
    end
    
    should "have follows? method return true if they're following a user" do
      @user.follows.create(:user => @user2)
      assert true, @user.reload.follows?(@user2)
    end

    should "have follows? method return false if they're not following a user" do
      @user.follows.destroy_all
      assert 0, @user.follows.count
      assert false, @user.follows?(@user2)      
    end
    
    should "have a feed composed of the messages of the users that the user follows" do
      assert Array, @user.feed.class
    end

  
  end

  context "destroying a user" do
    setup do
      @user_foo = users(:foo)
      @user_bar = users(:bar)
      Following.destroy_all
      @user_foo.followings.create(:follower => @user_bar)
    end
    
    should "remove all followings" do
      @user_bar.destroy
      assert 0, Following.count
    end
    
  end

end
