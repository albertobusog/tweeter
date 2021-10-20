require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
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
end
