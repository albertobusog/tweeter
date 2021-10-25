require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe "GET /photos - show action" do
    subject do
      get "/users/#{user_id}/photos", headers: headers
      response
    end

    let(:photo) do
      FactoryBot.create(:photo, user: user, url: '/home/user/Downloads/leon.jpg')
    end

    context 'the user does not exist' do
      let(:user_id) { 0 }
      let(:photo_id) { 0 }
#      it { expect(subject.parsed_body).to include({ "error" => 'Wrong token' }) }
    end

    context 'the user exists' do
      let(:user_id) { user.id }

      context 'but the photo does not exist' do
        let(:photo) do
          nil
        end

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
      
      context 'and the photo exists' do
        let(:photo_id) { photo.id }

        it do
          expect(subject.parsed_body).to include({ 'url' => '/home/user/Downloads/leon.jpg' })
        end
      end
    end
  end


  describe "POST /photos - create action" do
    subject do
      post "/users/#{user.id}/photos", headers: headers, params: params
      response
    end

    context 'the photo is created correctly' do
      let(:params) { { url: '/home/user/Downloads/leon.jpg' } }

      it do
        expect{ subject }.to change { user.photo }.from(nil).to have_attributes({
          url: '/home/user/Downloads/leon.jpg',
        })
        expect(subject.parsed_body).to include({
          "url" => "/home/user/Downloads/leon.jpg",
        })

      end
    end
  end

end
