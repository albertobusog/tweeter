require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users - index action" do
    subject do
      get '/users', headers: { ACCEPT: 'application/json' }
      response
    end

    context 'shows all users' do
      before do
        User.create(
          username: 'Gerardo',
          password: '1234',
          password_confirmation: '1234',
          full_name: 'Gerardo Rocha'  
        )
        User.create(
          username: 'Goku',
          password: '1234',
          password_confirmation: '1234',
          full_name: 'Son Goku'  
        )
      end

      it do
        expect(subject.parsed_body).to include(
          {
            "users" => [
              {
                  "username" => "Gerardo",
                  "full_name" => "Gerardo Rocha"
              },
              {
                  "username" => "Goku",
                  "full_name" => "Son Goku"
              }
            ]
          }
        )
      end
    end
  end

  describe "GET /users/:id - show action" do
    subject do
      get "/users/#{user_id}", headers: { ACCEPT: 'application/json' }
      response
    end

    let(:user) do
      FactoryBot.create(:user)
      # FactoryBot.create(:user, username: 'juan', full_name: 'Juan Perez')
    end

    context 'the user does not exist' do
      let(:user_id) { 0 }
      it { expect(subject.parsed_body).to include({ "error" => 'User not found' }) }
    end

    context 'the user exists' do
      let(:user_id) { user.id }
      it do
        expect(subject.parsed_body).to include({
          "username" => "tony",
          "full_name" => "Tony Stark",
        })
      end
    end
  end

  describe "POST /users - create action" do
    subject do
      post "/users", headers: { ACCEPT: 'application/json' }, params: params
      response
    end

    context 'the user is not created' do
      let(:params) do
        {
          user: {
            username: 's',
            password: '123456',
            password_confirmation: '123456',
            full_name: 'Steve Rogers',
          }
        }
      end

      it { expect(subject.parsed_body).to include('Username is too short (minimum is 2 characters)') }
    end

    context 'the user is created correctly' do
      let(:params) do
        {
          user: {
            username: 'steve',
            password: '123456',
            password_confirmation: '123456',
            full_name: 'Steve Rogers',
          }
        }
      end

      it do
        expect{ subject }.to change { User.first }.from(nil).to have_attributes({
          username: 'steve',
          full_name: 'Steve Rogers',
        })
        expect(subject.parsed_body).to include({
          "username" => "steve",
          "full_name" => "Steve Rogers",
        })

      end
    end
  end
end
