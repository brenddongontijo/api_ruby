require 'rails_helper'
require 'coveralls'
Coveralls.wear!('rails')

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  # Test suite for recovery all products (endpoint GET /products)
  describe 'GET /products' do
    before { get '/products' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all products stored' do
      expect(json.size).to eq(10)
    end
  end

  # Test suite for recovering a specific product (endpoint GET /products/:id)
  describe 'GET /products/:id' do
    before { get "/products/#{product_id}" }

    context 'when the product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the specific product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end
    end

    context 'when the product does not exist' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found error message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for creating a new product (endpoint POST /products)
  describe 'POST /products' do
    let(:valid_params) {{
      name: 'Foo', description: 'Bar', value: 9.99, height: 2,
      weight: 4, width: 6, length: 8 }}


    context 'when the params are correct' do
      before { post "/products", params: valid_params }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the params are incorrect' do
      before { post "/products", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a message with the errors' do
        expect(response.body).to match(/Validation failed/)
        expect(response.body).to match(/Name can't be blank/)
        expect(response.body).to match(/Description can't be blank/)
        expect(response.body).to match(/Value can't be blank/)
        expect(response.body).to match(/Height can't be blank/)
        expect(response.body).to match(/Weight can't be blank/)
        expect(response.body).to match(/Width can't be blank/)
        expect(response.body).to match(/Length can't be blank/)
      end
    end
  end

  # Test suite for updating a product (endpoint PUT /products/:id)
  describe 'PUT /products/:id' do
    let(:updated_params) {{ name: 'New Foo', description: 'New Bar' }}
    before { put "/products/#{product_id}", params: updated_params }

    context 'when the params are valid' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the product' do
        updated_product = Product.find(product_id)

        expect(updated_product.name).to eq(updated_params[:name])
        expect(updated_product.description).to eq(updated_params[:description])
      end
    end

    context 'when the product does not exists' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a message with the errors' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for deleting a product (endpoint DELETE /products/:id)
  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite freight of an specific product (endpoint GET /products/:id/freight)
  describe 'GET /products/:id/freight' do
    before { get "/products/#{product_id}/freight" }

    context 'when the freight is calculated correct' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns ' do
        expect(json['valor']).not_to eq(0)
      end
    end
  end
end
