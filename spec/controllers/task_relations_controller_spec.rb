require 'rails_helper'

=begin
RSpec.describe TaskRelationsController, :type => :controller do
  describe '#create' do
    context 'when signed out' do
      before :each do
        fake_login nil
      end

      it 'disallows the creation of task relations by unauthenticated users' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when signed in' do
      before :each do
        fake_login create(:user)
      end

      it 'renders a list of Task Relations' do
        get :index
        expect(response.status).to eq 200
      end
    end
  end

  describe '#index' do
    context 'when signed in' do
      before :each do
        fake_login create(:user)
      end

      it 'renders a page of all Task Relations' do
        get :index
        expect(response.body).to match //
      end
    end
  end
end
=end