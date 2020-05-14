require 'rails_helper'

RSpec.describe "UsersController", type: :request do

  describe "GET #index (root)" do

    before do
      @user = FactoryBot.create(:user)
      get users_url
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "should render /index" do
      expect(response).to render_template(:index)
    end

    it "show user's name" do
      expect(response.body).to include @user.name
    end
  end


  describe 'GET #new' do
    
    it "returns http success" do
      get new_user_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    before do
      @user = FactoryBot.create(:user)
      get edit_user_url @user
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "should show user's name" do
      expect(response.body).to include @user.name  
    end
  end

  describe 'POST #create' do
    
    context "a correct params" do
      
      it "returns http success" do
        post users_url, params: {user: FactoryBot.attributes_for(:user)}
        expect(response).to have_http_status(302)  
      end

      it "should registered user" do
        expect do
          post users_url, params: {user: FactoryBot.attributes_for(:user)}
        end.to change(User, :count).by(1)
      end

      it "should redirect" do
        post users_url, params: {user: FactoryBot.attributes_for(:user)}
        expect(response).to redirect_to root_url
      end
    end

    context "a wrong params" do
      it "returns http status 200" do
        post users_url, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response.status).to eq 200
      end

      it "should not registered user" do
        expect do
          post users_url, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        end.to_not change(User, :count)
      end

      it "should show user's error selector" do
        post users_url, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response.body).to have_selector("ul")
      end

      it "should not redirect" do
        post users_url, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response).to render_template :new
      end
    end
    
  end

  describe "PUT #update" do
    let(:user) {FactoryBot.create(:user)}
    context "a correct params" do
      it "returns http status 200" do
          put user_url user, params: {user: FactoryBot.attributes_for(:user, :takuya)}
          expect(response).to have_http_status 302
      end

      it "should update user" do
        expect do
          put user_url user, params: {user: FactoryBot.attributes_for(:user, :takuya)}
        end.to change {User.find(user.id).name}.from(user.name).to("takuya")
      end 

      it "should redirect to root_url" do
        put user_url user, params: {user: FactoryBot.attributes_for(:user, :takuya)}
        expect(response).to redirect_to root_path
      end
    end

    context "a wrong params" do
      it "returns http status 200" do
        put user_url user, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response).to have_http_status 200
      end

      it "should not updated user" do
        expect do
          put user_url user, params: {user: FactoryBot.attributes_for(:user, :invalid)}
        end.to_not change(user, :name)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user) {FactoryBot.create(:user)}

    it "returns http status 302" do
      delete user_url user
      expect(response).to have_http_status 302 
    end

    it "should destory user" do
      expect do
        delete user_url user
      end.to change(User, :count).by(-1)
    end

    it "should redirect to root_url" do
      delete user_url user
      expect(response).to redirect_to root_url  
    end
  end
  
  
  

end
