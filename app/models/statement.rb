class Statement < ApplicationRecord
    belongs_to :user
    has_many :transactions, dependent: :destroy
    validates :title, presence: true

    def income_expense_ratio
        if !transactions.where(transaction_type: 'debit').empty?
            debits = transactions.where(transaction_type: 'debit').sum(:amount)
        else
            debits = 0
        end
        if !transactions.where(transaction_type: 'credit').empty?
            credits = transactions.where(transaction_type: 'credit').sum(:amount)
        else
            return nil
        end
        return (debits / credits.to_f).round(2)
    end

    def disposable_income
        if !transactions.where(transaction_type: 'credit').empty?
            credits = transactions.where(transaction_type: 'credit').sum(:amount)
        else
            return nil
        end
        if !transactions.where(transaction_type: 'debit').empty?
            debits = transactions.where(transaction_type: 'debit').sum(:amount)
        else
            debits = 0
        end
        return (credits - debits)
    end

    def income_expense_rating
        ratio = income_expense_ratio
        return "N/A" if ratio.nil?
        if ratio < 0.1
            return "A"
        elsif ratio > 0.1 && ratio < 0.3
            return "B"
        elsif ratio > 0.3 && ratio < 0.5
            return "C"
        else
            return "D"
        end
    end
end
