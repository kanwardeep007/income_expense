class Statement < ApplicationRecord
    belongs_to :user
    has_many :transactions, dependent: :destroy
    validates :title, presence: true

    # def income_expense_ratio
    #     transactions.where(transaction_type: 'debit').sum(:amount) / transactions.where(transaction_type: 'credit').sum(:amount)
    # end
end
