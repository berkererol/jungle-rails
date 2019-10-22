require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    cat = Category.new(name:"Test")
    subject {described_class.new(price_cents:100, name: 'Anything', quantity: 1, category: cat)}
    
    describe 'Name validation' do 
      it 'is valid with a valid name' do
        subject.name = 'Anything' #valid state
        expect(subject).to be_valid
      end
      it 'is not valid without a valid name' do
        subject.name = nil #invalid state
        subject.valid?
        expect(subject.errors[:name].first).to include("can't be blank")
      end
    end

    describe 'Price validation' do
      it 'has a valid price' do
        subject.price_cents=100
        expect(subject).to be_valid
      end
      it 'does not have a valid price' do
        subject.price_cents=nil #invalid state
        subject.valid?
        expect(subject.errors[:price_cents].first).to include("is not a number")
      end
    end

    describe 'Quantity validation' do
      it 'has a valid quantity' do
        expect(subject).to be_valid
      end
      it 'does not have a valid quantity' do
        subject.quantity = nil
        subject.valid?
        expect(subject.errors[:quantity].first).to include("can't be blank")
      end
    end

    describe 'Category validation' do
      it 'has a valid category' do
        expect(subject).to be_valid
      end
      it 'does not have a valid category' do
        subject.category = nil
        subject.valid?
        expect(subject.errors[:category].first).to include("can't be blank")
      end
    end

  end
end