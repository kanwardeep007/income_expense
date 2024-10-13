
class StatementsController < ApplicationController
  def index
    @statements = Statement.all
  end

  def new
    @statement = Statement.new
    @statement.income_items.build
    @statement.expense_items.build
  end

  def create
    @statement = Statement.new(statement_params)
    if @statement.save
      render json: { success: true, message: 'Statement created successfully' }
    else
      render json: { success: false, errors: @statement.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def statement_params
    params.require(:statement).permit(
      :month, :year, :name,
      income_items_attributes: [:description, :amount],
      expense_items_attributes: [:description, :amount]
    )
  end
end