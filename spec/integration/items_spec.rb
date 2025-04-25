require 'swagger_helper'

RSpec.describe 'items', type: :request do

  path '/items' do

    get('Get all shopping items') do
      tags 'Items'
      description 'Retrieves a list of all shopping items'
      operationId 'getItems'
      produces 'application/json'

      response(200, 'Successful operation') do
        #schema type: :array, items: { '$ref' => '#/components/schemas/Item' }
        run_test!
      end

      response(500, 'Server error') do
        before do
          allow(Item).to receive(:all).and_raise(StandardError, 'Simulated server error')
        end

        run_test!
      end
    end

    post('Create or update a shopping item') do
      tags 'Items'
      description 'Adds a new item to the shopping list or increases quantity if the item name already exists'
      operationId 'createOrUpdateItem'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Bananas' },
          quantity: { type: :integer, example: 5 }
        },
        required: ['name', 'quantity']
      }

      response(201, 'Item created successfully') do
        let(:item) { { name: 'Bananas', quantity: 5 } }
        run_test!
      end

      response(200, 'Item updated successfully') do
        let(:item) { { name: 'Bananas', quantity: 10 } }
        before do
          Item.create!(name: 'Bananas', quantity: 5)
        end
        run_test!
      end

      response(400, 'Invalid input') do
        let(:item) { { name: '' } }
        run_test!
      end

      response(500, 'Server error') do
        before do
          allow(Item).to receive(:create).and_raise(StandardError, 'Simulated server error')
        end

        let(:item) { { name: 'Bananas', quantity: 5 } }
        run_test!
      end
    end
  end

  path '/items/{itemId}' do
    parameter name: :itemId, in: :path, type: :integer, description: 'ID of the item'

    get('Get item by ID') do
      tags 'Items'
      description 'Retrieves a specific shopping item by its ID'
      operationId 'getItemById'
      produces 'application/json'

      response(200, 'Successful operation') do
        let(:itemId) { Item.create!(name: 'Apples', quantity: 10).id }
        #schema '$ref' => '#/components/schemas/Item'
        run_test!
      end

      response(404, 'Item not found') do
        let(:itemId) { 'invalid' }
        run_test!
      end

      response(500, 'Server error') do
        let(:itemId) { 1 } # Dummy-ID, da der Fehler vor der Datenbankabfrage ausgelöst wird

        before do
          allow(Item).to receive(:find).and_raise(StandardError, 'Simulated server error')
        end

        run_test!
      end
    end

    put('Update an item') do
      tags 'Items'
      description 'Updates an existing shopping item'
      operationId 'updateItem'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Bananas' },
          quantity: { type: :integer, example: 5 }
        },
        required: ['name', 'quantity']
      }

      response(200, 'Item updated successfully') do
        let(:itemId) { Item.create!(name: 'Oranges', quantity: 5).id }
        let(:item) { { name: 'Oranges', quantity: 10 } }
        run_test!
      end

      response(400, 'Invalid input') do
        let(:itemId) { Item.create!(name: 'Oranges', quantity: 5).id }
        let(:item) { { name: '' } }
        run_test!
      end

      response(404, 'Item not found') do
        let(:itemId) { 'invalid' }
        let(:item) { { name: 'Oranges', quantity: 10 } }
        run_test!
      end

      response(500, 'Server error') do
        let(:itemId) { 1 } # Dummy-ID, da der Fehler vor der Datenbankabfrage ausgelöst wird

        before do
          allow(Item).to receive(:find).and_raise(StandardError, 'Simulated server error')
        end

        let(:item) { { name: 'Oranges', quantity: 10 } }
        run_test!
      end
    end

    delete('Delete an item') do
      tags 'Items'
      description 'Removes a shopping item from the list'
      operationId 'deleteItem'
      produces 'application/json'

      response(204, 'Item deleted successfully') do
        let(:itemId) { Item.create!(name: 'Grapes', quantity: 3).id }
        run_test!
      end

      response(404, 'Item not found') do
        let(:itemId) { 'invalid' }
        run_test!
      end

      response(500, 'Server error') do
        let(:itemId) { 1 } # Dummy-ID, da der Fehler vor der Datenbankabfrage ausgelöst wird

        before do
          allow(Item).to receive(:destroy).and_raise(StandardError, 'Simulated server error')
        end

        run_test!
      end
    end
  end
end
