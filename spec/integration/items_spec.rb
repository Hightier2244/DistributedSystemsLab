require 'swagger_helper'

RSpec.describe 'v1/items', type: :request do

  path '/v1/items' do

    get('Get all shopping items') do
      tags 'Items'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end

    post('Create or update a shopping item') do
      tags 'Items'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          quantity: { type: :integer }
        },
        required: [ 'name', 'quantity' ]
      }

      response(201, 'created') do
        let(:item) { { name: 'Bananas', quantity: 5 } }
        run_test!
      end

      response(200, 'updated') do
        let(:item) { { name: 'Bananas', quantity: 2 } }
        before do
          Item.create!(name: 'Bananas', quantity: 3)
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:item) { { name: '' } }
        run_test!
      end
    end
  end
end
