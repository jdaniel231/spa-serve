require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  # let(:user) { create :user, password: '123123123' }
  # let(:token) { token_generator(user.id) }

  let(:movies) do
    [
      attributes_for(:movie, name: "La sombra del amor", year: 2000),
      attributes_for(:movie, name: "Spider-Man", year: 2018)
    ]
  end

  let(:valid_attributes) do
    {
      name: "Terror",
      description: "Descripción de Terror",
      movies_attributes: movies
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      description: "Descripción de Terror",
      movies_attributes: movies
    }
  end

  # before { request.headers['HTTP_AUTHORIZATION'] = token }

  describe "GET #index" do
    it "returns a success response" do
      Category.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      get :show, params: {id: category.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {category: valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "creates a new Category increment Movies" do
        expect {
          post :create, params: {category: valid_attributes}
        }.to change(Movie, :count).by(2)
      end

      it "renders a JSON response with the new category" do

        post :create, params: {category: valid_attributes}
        expect(response).to have_http_status(:created)
        # expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(category_url(Category.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new category" do

        post :create, params: {category: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        # expect(response.content_type).to eq('application/json')
      end
   end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Terror Actualizado",
          description: "Descripción de Terror"
        }
      end

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, params: {id: category.to_param, category: new_attributes}
        category.reload
        expect(category.name).to eq "Terror Actualizado"
      end

      it "renders a JSON response with the category" do
        category = Category.create! valid_attributes

        put :update, params: {id: category.to_param, category: valid_attributes}
        expect(response).to have_http_status(:ok)
        # expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = Category.create! valid_attributes

        put :update, params: {id: category.to_param, category: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        # expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      # expect {
      #   delete :destroy, params: {id: category.to_param}
      # }.to change(Category, :count).by(-1)
    end
  end

end