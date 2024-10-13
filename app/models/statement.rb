class Statement < ApplicationRecord
    has_many :transactions, dependent: :destroy
  end