require 'rails_helper'

RSpec.describe 'Groups', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456')

    sign_in @user, scope: :user

    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    file = File.open(file_path)
    @group = Group.new(name: 'Test group', author_id: @user.id)
    @group.icon.attach(io: file, filename: 'back.png', content_type: 'image/png')
    @group.save
  end

  describe 'group page' do
    scenario 'should have a group page' do
      visit groups_path
      expect(page).to have_content('Add new category')
    end
    scenario 'should have the name of the group' do
      visit groups_path
      expect(page).to have_content(@group.name)
    end
    scenario 'should have a  total amount' do
      visit groups_path
      expect(page).to have_content(@user.expenses.sum(:amount))
    end
    scenario 'when user clicks on add a new category link it will redirect to new group page' do
      visit groups_path
      click_button 'Add new category'
      expect(page).to have_content('Choose Image:')
    end
  end
  describe 'new group page' do
    scenario 'should have a new group page' do
      visit new_group_path
      expect(page).to have_content('Choose Image:')
    end
    scenario 'when a user click save button with valid data it will redirect to group page' do
      visit new_group_path
      fill_in 'Name', with: 'Test group'
      click_button 'Save'
      expect(page).to have_content('Choose Image:')
    end
  end
end
