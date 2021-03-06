require 'spec_helper'

describe HitsController do

  context "unauthenticated" do
    let(:user) { FactoryGirl.create(:user) }
    let(:hit)  { FactoryGirl.create(:hit) }

    describe "should not allow access to GET #index" do
      before { get :index }
      it "does not render the :index view" do
        response.should_not render_template :index
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #show" do
      before { get :show, id: hit }
      it "does not render the :show view" do
        response.should_not render_template :show
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #new" do
      before { get :new }
      it "does not render the :new view" do
        response.should_not render_template :new
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to POST #create" do
      it "does not create a new hit" do
        expect {
          post :create, hit: FactoryGirl.attributes_for(:hit)
        }.to_not change(User, :count)
      end
      it "redirects to signin page" do
        post :create, hit: FactoryGirl.attributes_for(:hit)
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to GET #edit" do
      before { get :edit, id: hit }
      it "does not render the :edit view" do
        response.should_not render_template :edit
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "should not allow access to PUT #update" do
      let(:user) { FactoryGirl.create(:user) }
      let(:hit) { FactoryGirl.create(:hit) }
      before {
             put :update, id: hit,
             hit: FactoryGirl.attributes_for(:hit, audio_file: "wrong") }
      it "does not change the user" do
        hit.reload
        hit.audio_file.should_not eq("wrong")
      end
      it "redirects to signin page" do
        response.should redirect_to(new_user_session_path)
      end
    end
  end

# ----
  context "authenticated as user" do
    let(:user)   { FactoryGirl.create(:user) }
    let(:target) { FactoryGirl.create(:target) }
    let(:hit)    { FactoryGirl.create(:hit) }

    before { sign_in user }

    describe "GET #index" do
      describe "should allow access" do
        before { get :index }
        it "renders the :index view" do
          response.should render_template :index
          assigns(:hits).should eq([hit])
        end
      end
      describe "should allow filtering by GET params" do
        before do
          FactoryGirl.create(:target, id: 500)
          FactoryGirl.create(:hit, target_id: 500)
          FactoryGirl.create(:hit, confirmed: 1)
          FactoryGirl.create(:hit, flagged: true)
        end

        describe "filtering by target" do
          before { get :index, target_id: '500' }
          it "returns the right results" do
            assigns(:hits).length.should eq(1)
          end
        end
        describe "filtering by confirmation status" do
          before { get :index, confirmed: '1' }
          it "returns the right results" do
            assigns(:hits).length.should eq(1)
          end
        end
        describe "filtering by flagged status" do
          before { get :index, flagged: 'true' }
          it "returns the right results" do
            assigns(:hits).length.should eq(1)
          end
        end
      end
      describe "should paginate" do
        before do
          31.times do |n|
            FactoryGirl.create(:hit)
          end
          get :index
        end
        it "returns fewer than 30 hits" do
          assigns(:hits).length.should be < 31
        end
      end
    end # GET #index

    describe "should allow access to GET #show" do
      before { get :show, id: hit }
      it "renders the :show view" do
        response.should render_template :show
        assigns(:hit).should eq(hit)
      end
    end

    describe "should not allow access to GET #new" do
      before { get :new }
      it "does not render the :new view" do
        response.should_not render_template :new
      end
      it "redirects to signin page" do
        response.should redirect_to(user_path(user))
      end
    end

    describe "should not allow access to POST #create" do
      it "does not create a new hit" do
        expect {
          post :create, target: target,
                        hit: FactoryGirl.attributes_for(:hit)
        }.to_not change(Hit, :count)
      end
      it "redirects to signin page" do
        post :create, user: user,
                      target: FactoryGirl.attributes_for(:hit)
        response.should redirect_to(user_path(user))
      end
    end

    # I uh... don't know how to fix this. Something about setting recent.
    describe "should allow access to PUT #update" do
      it "changes the hit" do
        put :update, id: hit,
                hit: FactoryGirl.attributes_for(:hit, audio_file: 'right')
        hit.reload
        hit.audio_file.should eq('right')
      end
    end
  end

# ----
  #  "authenticated as admin" do
  #   let(:admin) { FactoryGirl.create(:admin) }
  #   let(:hit) { FactoryGirl.create(:hit) }

  #   before { sign_in admin }

  #   describe "should allow access to GET #new" do
  #     before { get :new }
  #     it "renders the :new view" do
  #       response.should render_template :new
  #       assigns(:hit).should_not be_nil
  #     end
  #   end
  #   describe "should allow access to POST #create" do
  #     context "with valid information" do
  #       let(:new_hit) { FactoryGirl.attributes_for(:hit) }
  #       it "creates a new hit" do
  #         expect{ post :create, hit: new_hit }.to change(Hit, :count).by(1)
  #       end
  #       it "redirects to new hit's page" do
  #         post :create, target: new_target
  #         response.should render_template :show
  #         assigns(:hit).should_not be_nil
  #       end
  #     end
  #     context "with invalid information" do
  #       let(:new_hit) { FactoryGirl.attributes_for(:hit, confirmed: -6 ) }
  #       it "does not create a new hit" do
  #         expect{ post :create, hit: new_hit }.to_not change(Hit, :count)
  #       end
  #       it "remains on new hit page" do
  #         response.should render_template :new
  #         assigns(:hit).should_not be_nil
  #       end
  #     end
  #   end
  # end
end
