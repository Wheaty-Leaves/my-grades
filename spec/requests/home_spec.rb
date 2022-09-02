require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "Home", type: :request do

  context 'GET index as non signed in user' do
    it 'redirects to the sign in path' do
      get root_path
      expect(response).to redirect_to(authentication_login_path)
    end
  end

  context 'signed in as student' do
    it 'GET index signed in as student' do
      sign_in build(:student)
      get root_path
      expect(response).to be_successful
    end
  end

  context 'signed out as student' do
    it 'GET index then redirect as signed out student' do
      sign_in build(:student)
      get root_path
      sign_out :student
      get root_path
      expect(response).to redirect_to(authentication_login_path)
    end
  end

  context 'signed in as teacher' do
    it 'GET index signed in as teacher' do
      sign_in build(:teacher)
      get root_path
      expect(response).to be_successful
    end
  end

  context 'signed out as teacher' do
    it 'GET index then sign out and refresh page' do
      sign_in build(:teacher)
      get root_path
      sign_out :teacher
      get root_path
      expect(response).to redirect_to(authentication_login_path)
    end
  end
end
