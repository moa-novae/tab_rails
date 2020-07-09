require 'rails_helper'

RSpec.describe User, type: :model do 

  subject { described_class.new(
    name: 'Name',
    phone: '1234567890',
    password: 'password'
  )
  }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do 
    subject.name = nil 
    expect(subject).to_not be_valid
  end
  it 'is not valid without a password' do
    subject.password = nil 
    expect(subject).to_not be_valid
  end
  it 'is not valid without a phone' do
    subject.phone = nil
    expect(subject).to_not be_valid
  end
end