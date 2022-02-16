require 'rails_helper'

RSpec.describe "Categories", type: :request do

  describe "GET /api/categories" do
    it "deve retornar a lista de categorias" do
      get categories_path, headers: @env
      expect(response).to have_http_status(200)
    end
  end

    describe "GET /api/categories/:id" do
    let(:category) { create :category }

    it "deve retornar uma categoria" do
      get category_path(category.id), headers: @env
      expect(response).to have_http_status(200)
    end
  end
end
