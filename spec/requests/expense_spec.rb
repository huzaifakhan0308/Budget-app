require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  include Devise::Test::IntegrationHelpers
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
  describe 'GET /expenses' do
    it 'returns http success' do
      get group_expenses_path(group_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the index template' do
      get group_expenses_path(group_id: @group.id)
      expect(response).to render_template('index')
    end
    it 'displays the expense name' do
      get group_expenses_path(group_id: @group.id)
      expect(response.body).to include('TRANSACTIONS')
    end
  end
  describe 'GET /expenses/new' do
    it 'returns http success' do
      get new_group_expense_path(group_id: @group.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get new_group_expense_path(group_id: @group.id)
      expect(response).to render_template('new')
    end
    it 'displays the new expense form' do
      get new_group_expense_path(group_id: @group.id)
      expect(response.body).to include('ADD TRANSACTIONS')
    end
  end
end
