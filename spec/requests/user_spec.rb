require 'rails_helper'

RSpec.describe 'Users', type: :request do
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

  describe 'GET /' do
    it 'returns http success' do
      get authenticated_root_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get authenticated_root_path
      expect(response).to render_template('groups/index').or(render_template('/'))
    end

    it 'displays sign in' do
      get unauthenticated_root_path
      expect(response.body).to include('Log in')
    end
  end

  describe 'GET /users/sign_in' do
    it 'returns http success' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end

    it 'renders the new template' do
      get new_user_session_path
      expect(response).to render_template('devise/sessions/new').or(render_template('new'))
    end

    it 'displays the sign in form' do
      get new_user_session_path
      expect(response.body).to include('Log in')
    end
  end

  describe 'GET /users/sign_up' do
    it 'returns http success' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end

    it 'renders the new template' do
      get new_user_registration_path
      expect(response).to render_template('devise/registrations/new').or(render_template('new'))
    end

    it 'displays the sign up form' do
      get new_user_registration_path
      expect(response.body).to include('Sign up')
    end
  end
end
