# frozen_string_literal: true

module Api
  module V1
    class StatesController < ApplicationController
      def index
        states = State.order('created_at ASC')
        render json: { status: 'SUCCESS', message: 'Estados carregados', data: states },
               status: :ok
      end

      def show
        state = State.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Estados carregados', data: state },
               status: :ok
      end

      def create
        state = State.new(state_params)
        if state.save
          render json: { status: 'SUCCESS', message: 'Estado salvo', data: state }, status: :created
        else
          render json: { status: 'ERROR', message: 'Estado não salvo', data: state.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        state = State.find(params[:id])
        if state.update(state_params)
          render json: { status: 'SUCCESS' }, status: :no_content
        else
          render json: { status: 'ERROR' }, status: :unprocessable_entity
        end
      end

      def destroy
        state = State.find(params[:id])
        state.destroy
        render json: { status: 'SUCCESS', message: 'Estado deletado ', data: state }, status: :ok
      end

      private

      def state_params
        params.permit(:name, :uf)
      end
    end
  end
end
