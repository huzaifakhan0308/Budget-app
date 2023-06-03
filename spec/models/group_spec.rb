require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456')
    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    file = File.open(file_path)
    @group = Group.new(name: 'Test group', author_id: @user.id)
    @group.icon.attach(io: file, filename: 'back.png', content_type: 'image/png')
    @group.save
  end
  it 'is valid with valid attributes' do
    expect(@group).to be_valid
  end
  it 'is not valid without a name' do
    @group.name = nil
    expect(@group).to_not be_valid
  end
  it 'is not valid without an icon' do
    @group.icon = nil
    expect(@group).to_not be_valid
  end
  it 'is not valid without an author_id' do
    @group.author_id = nil
    expect(@group).to_not be_valid
  end
end
