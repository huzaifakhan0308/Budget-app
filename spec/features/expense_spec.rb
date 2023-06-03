require 'rails_helper'

RSpec.describe 'Expenses', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456')

    sign_in @user, scope: :user

    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    file = File.open(file_path)
    @group = Group.new(name: 'Test group', author_id: @user.id)
    @group.icon.attach(io: file, filename: 'back.png', content_type: 'image/png')
    @group.save

    @expense = Expense.create(name: 'Test expense', amount: 100, author_id: @user.id, groups_id: @group.id)
  end
  describe 'Expense detail page' do
    scenario 'should have a expense detail page' do
      visit group_expenses_path(@group)
      expect(page).to have_content(@group.name)
    end
    scenario 'should have a expense total' do
      visit group_expenses_path(@group)
      expect(page).to have_content(Expense.where(groups_id: @group.id).sum(:amount))
    end
    scenario 'should have add new expense link' do
      visit group_expenses_path(@group)
      expect(page).to have_content('Add new transaction')
    end
    scenario 'When user click add a new transaction button will redirect to transaction new page' do
      visit group_expenses_path(@group)
      click_link 'Add new transaction'
      expect(page).to have_content('ADD TRANSACTIONS')
    end
  end
  describe 'Expense new page' do
    scenario 'should have a expense new page' do
      visit new_group_expense_path(@group)
      expect(page).to have_content('ADD TRANSACTIONS')
    end
    scenario 'when the user clicks the save button with valid data, it will redirect to the expense detail page' do
      visit new_group_expense_path(@group)
      fill_in 'Name', with: 'Test expense'
      fill_in 'Amount', with: 100
      select 'Test group', from: 'expense[groups_id]'
      click_button 'Save'
      expect(page).to have_content('Add new transaction')
    end
  end
end
