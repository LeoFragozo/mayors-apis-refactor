# frozen_string_literal: true

module Api
  module V1
    class MayorsController < ApplicationController
      def index
        mayors = Mayor.filter_by_gender(params[:gender])
        mayors = mayors.filter_by_gender(params[:gender]) if params[:gender].present?

        render json: { status: 'SUCCESS', message: 'Prefeit/o/a/s carregado/a/s', data: mayors },
               status: :ok
      end

      def show
        mayor = Mayor.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Prefeito/as carregado/as', data: mayor },
               status: :ok
      end

      def create
        mayor = Mayor.new(mayor_params)
        if mayor.save
          render json: { status: 'SUCCESS', message: 'Prefeito/a salvo/a', data: mayor }, status: :created
        else
          render json: { status: 'ERROR', message: 'Prefeito/a não salvo/a', data: mayor.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        mayor = Mayor.find(params[:id])
        if mayor.update(mayor_params)
          render json: { status: 'SUCCESS' }, status: :no_content
        else
          render json: { status: 'ERROR' }, status: :unprocessable_entity
        end
      end

      def destroy
        mayor = Mayor.find(params[:id])
        mayor.destroy
        render json: { status: 'SUCCESS', message: 'Prefeito/a deletado/deletada ', data: mayor }, status: :ok
      end

      private

      def mayor_params
        params.permit(:name, :gender, :city_id)
      end
    end
  end
end
