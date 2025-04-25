class ItemsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
    before_action :set_item, only: [:show, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'Item not found' }, status: :not_found
    end

    def index
      items = Item.all
      render json: items
    end

    def show
      render json: @item
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Item not found" }, status: :not_found
    end

    def create
      item = Item.find_by(name: item_params[:name])
      if item
        item.increment!(:quantity, item_params[:quantity].to_i)
        render json: item, status: :ok
      else
        item = Item.new(item_params)
        if item.save
          render json: item, status: :created
        else
          render json: { error: item.errors.full_messages }, status: :bad_request
        end
      end
    end

    def update
      if @item.update(item_params)
        render json: @item
      else
        render json: { error: @item.errors.full_messages }, status: :bad_request
      end
    end

    def destroy
      @item.destroy
      head :no_content
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :quantity)
    end
  end
