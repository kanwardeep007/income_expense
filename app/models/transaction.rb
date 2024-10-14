class Transaction < ApplicationRecord
    belongs_to :statement
    VALID_TRANSACTION_TYPES = ['credit', 'debit']

    validates :transaction_type, inclusion: { in: VALID_TRANSACTION_TYPES }
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :transaction_type, presence: true
    validates :settled_timestamp, presence: true
end
