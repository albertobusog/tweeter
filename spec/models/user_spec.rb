require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:attributes) do 
      {
        username: 'Gerardo',
        password: 'asdf',
        password_confirmation: 'asdf',
        full_name: 'Son Goku'
      }
    end

    subject { User.create(attributes).valid? }

    it { expect(subject).to be true }

    context 'username' do
      context 'is invalid when length is less than 2' do
        let(:attributes) do 
          {
            username: 'G',
            password: 'asdf',
            password_confirmation: 'asdf',
            full_name: 'Son Goku'
          }
        end

        it { expect(subject).to be false }
      end

      context 'is invalid when length is more than 10' do
        let(:attributes) do 
          {
            username: 'GerardoRocha',
            password: 'asdf',
            password_confirmation: 'asdf',
            full_name: 'Son Goku'
          }
        end

        it { expect(subject).to be false }
      end

      context 'is invalid if not unique' do
        before do
          User.create(attributes)
        end

        it { expect(subject).to be false }
      end
    end
  end
end
