# frozen_string_literal: true

module Api
  module V1
    class MayorsController < ApplicationController
      def index
        mayors = Mayor.filter_by_gender('Male') #Todo change male to database info
        mayors = mayors.filter_by_gender(params[:gender]) if params[:gender].present?
        binding.pry
        render json: { status: 'SUCCESS', message: 'Prefeito/s carregado/s', data: mayors },
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
          render json: { status: 'SUCCESS', message: 'Prefeito/a salvo/a', data: mayor }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Prefeito/a não salvo/a', data: mayor.erros },
                 status: :unprocessable_entity
        end
      end

      def update
        mayor = Mayor.find(params[:id])
        if mayor.update(mayor_params)
          render json: { status: 'SUCCESS', message: 'Prefeito/a atualizado/a', data: mayor }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Prefeito/a não atualizado/a', data: mayor.erros },
                 status: :unprocessable_entity
        end
      end

      def destroy
        mayor = Mayor.find(params[:id])
        mayor.destroy
        render json: { status: 'SUCCESS', message: 'Prefeito/a deletado/deletada ', data: mayor }, status: :ok
      end

      def is_male
        mayors = MayorSerializer.new(Mayor.is_male)
        render json: { status: 'SUCCESS', message: 'Dados dos prefeitos carregados', each_serializer: MayorSerializer },
               status: :ok
      end

      def is_female
        mayors = MayorSerializer.new(Mayor.is_female)
        render json: { status: 'SUCCESS', message: 'Dados das prefeitas carregadas', each_serializer: MayorSerializer },
               status: :ok
      end

      private

      def mayor_params
        params.require(:mayor).permit(:name, :gender)
      end
    end
  end
end
