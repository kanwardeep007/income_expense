class TransactionsController < ApplicationController
    def create
        @statement = Statement.find(params[:statement_id])
        @transaction = @statement.transactions.new(transaction_params)
        if !@transaction.valid?
            @transaction_amount_errors = @transaction.errors.full_messages_for(:amount)
            @transaction_transaction_type_errors = @transaction.errors.full_messages_for(:transaction_type)
            @transaction_settled_timestamp_errors = @transaction.errors.full_messages_for(:settled_timestamp)
        end
        if @transaction.save
            redirect_to statement_path(@statement)
        else
            render 'statements/show', status: :unprocessable_entity
        end
      end

      def transaction_params
        params.require(:transaction).permit(:amount, :transaction_type, :settled_timestamp)
      end
end
