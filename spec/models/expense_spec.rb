require 'rails_helper'

RSpec.describe Expense, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456')
    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    file = File.open(file_path)
    @group = Group.new(name: 'Test group', author_id: @user.id)
    @group.icon.attach(io: file, filename: 'back.png', content_type: 'image/png')
    @group.save
    @expense = Expense.create(name: 'Test expense', amount: 100.0, author_id: @user.id, groups_id: @group.id)
  end
  it 'is valid with valid attributes' do
    expect(@expense).to be_valid
  end
  it 'is not valid without a name' do
    @expense.name = nil
    expect(@expense).to_not be_valid
  end
  it 'is not valid without an amount' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end
  it 'is not valid without an author_id' do
    @expense.author_id = nil
    expect(@expense).to_not be_valid
  end
end
