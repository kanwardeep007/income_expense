class CreateStatements < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE TABLE Statements(
     id serial primary key,
     title text,
     created_at timestamp with time zone,
     updated_at timestamp with time zone
    );"
  end
  def down
    execute "DROP TABLE Statements;"
  end
end
