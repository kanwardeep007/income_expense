class Transactions < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE TYPE transaction_type_enum AS ENUM ('credit', 'debit');"
    execute "CREATE TABLE Transactions (
     id serial primary key,
     statement_id integer references Statements(id),
     amount integer,
     transaction_type transaction_type_enum,
     settled_timestamp timestamp with time zone,
     updated_at timestamp with time zone,
     created_at timestamp with time zone,
     constraint amount_non_negative check (amount >= 0)
    );"
  end
  def down
    execute "DROP TYPE transaction_type_enum CASCADE;"
    execute "DROP TABLE Transactions CASCADE;"
  end
end
