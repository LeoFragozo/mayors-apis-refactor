# frozen_string_literal: true

module Api
  module V1
    class CitiesController < ApplicationController
      def index
        cities = City.order('created_at ASC')
        render json: { status: 'SUCCESS', message: 'Cidades carregadas', data: cities },
               status: :ok
      end

      def show
        city = City.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Cidades carregadas', data: city },
               status: :ok
      end

      def create
        city = City.create(city_params)
        if city.save
          render json: { status: 'SUCCESS', message: 'Cidade salva', data: city }, status: :created
        else
          render json: { status: 'ERROR', message: 'Erro ao criar cidade', data: city.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        city = City.find(params[:id])
        if city.update(city_params)
          render json: { status: 'SUCCESS' }, status: :no_content
        else
          render json: { status: 'ERROR' }, status: :unprocessable_entity
        end
      end

      def destroy
        city = City.find(params[:id])
        city.destroy
        render json: { status: 'SUCCESS', message: 'Cidade deletada ', data: city }, status: :ok
      end

      private

      def city_params
        params.permit(:name, :state_id)
      end
    end
  end
end
