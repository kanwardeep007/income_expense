class Transaction < ApplicationRecord
    belongs_to :statement
    enum transaction_type: [:credit, :debit]
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :transaction_type, presence: true
    validates :settled_timestamp, presence: true
end
