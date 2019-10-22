require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {described_class.new(first_name: 'Berker', last_name: 'Erol', email: 'berkererol@me.com', password: 'berker123', password_confirmation: 'berker123')}
    describe 'Password exists' do 
      it 'is valid with a valid password' do
        expect(subject).to be_valid
      end
      it 'should have a password' do
        subject.password = nil
        subject.valid?
        expect(subject.errors[:password].first).to eq"can't be blank"
      end
    end

    describe 'Password_confirmation exists' do 
      it 'is valid with a valid password_confirmation' do
        expect(subject).to be_valid
      end
      it 'should have a password_confirmation' do
        subject.password_confirmation = nil
        subject.valid?
        expect(subject.errors[:password_confirmation].first).to eq"can't be blank"
      end
    end

    describe 'Password matches' do
      it 'is valid with the same password and confirmation' do
        expect(subject).to be_valid
      end
      it 'is invalid without same password and confirmation' do
        subject.password='123456'
        subject.valid?
        expect(subject.errors[:password_confirmation].first).to eq"doesn't match Password"
      end
    end
    
    describe 'Email exists' do 
      it 'is invalid without the email' do
        subject.email=nil
        subject.valid?
        expect(subject.errors[:email].first).to eq"can't be blank"
      end
    end

    describe 'Password length' do
      it 'is valid with length within 6 to 20' do
        expect(subject).to be_valid
      end
      it 'is invalid with length of 5' do
        subject.password = '12345'
        subject.password_confirmation='12345'
        subject.valid?
        expect(subject.errors[:password].first).to eq"is too short (minimum is 6 characters)"
      end
      it 'is invalid with length of more than 20' do
        subject.password = 'qweasdzxc123qweasdzxc'
        subject.password_confirmation = 'qweasdzxc123qweasdzxc'
        subject.valid?
        expect(subject.errors[:password].first).to eq"is too long (maximum is 20 characters)"
      end
    end

    describe 'Email uniqueness' do
      it 'should have unique email address' do
        user = User.new(first_name: 'Foo', last_name:'Bar', email: 'berkererol@me.com', password: 'berker123', password_confirmation: 'berker123')
        user.save
        subject.valid?
        expect(subject.errors[:email].first).to eq"has already been taken"
      end
    end

  end
  describe '.authenticate_with_credentials' do

    it 'should pass with the correct email and password' do
      user = User.new(first_name: 'Foo', last_name:'Bar', email: 'berker@me.com', password: 'berker123', password_confirmation: 'berker123')
      user.save
      result = User.authenticate_with_credentials('berker@me.com', 'berker123')
      expect(result).to_not eq(nil)
    end
    
    it 'should not pass with wrong email and password' do
      user = User.new(first_name: 'Foo', last_name:'Bar', email: 'berker@me.com', password: 'berker123', password_confirmation: 'berker123')
      user.save
      result = User.authenticate_with_credentials('berker@meh.com', 'berker123')
      expect(result).to eq(nil)
    end

    it 'should ignore case' do
      user = User.new(first_name: 'Foo', last_name:'Bar', email: 'berker@me.com', password: 'berker123', password_confirmation: 'berker123')
      user.save
      result = User.authenticate_with_credentials('BERKER@me.COM', 'berker123')
      expect(result).to_not eq(nil)
    end

    it 'should ignore spaces' do
      user = User.new(first_name: 'Foo', last_name:'Bar', email: 'berker@me.com', password: 'berker123', password_confirmation: 'berker123')
      user.save
      result = User.authenticate_with_credentials(' berker@me.com', 'berker123')
      expect(result).to_not eq(nil)
    end
  end
end