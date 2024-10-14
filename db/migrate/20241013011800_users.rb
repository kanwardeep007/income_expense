class Users < ActiveRecord::Migration[8.0]
  def up
    execute "CREATE TABLE Users (
     id serial primary key,
     name text,
     email text unique,
     created_at timestamp with time zone,
     updated_at timestamp with time zone
    );"

    # execute "CREATE TABLE Statement_Transactions(
    #  user_id integer references Users(id),
    #  statement_id integer references Statements(id),
    #  primary key (user_id, statement_id)
    # );"
    execute "CREATE TABLE User_Statements(
     user_id integer references Users(id),
     statement_id integer references Statements(id),
     primary key (user_id, statement_id)
    );"
    # execute "CREATE TABLE User_Income_Statistics(
    #  id serial primary key,
    #  user_id integer references Users(id),
    #  month integer,
    #  year integer,
    #  disposable_income integer,
    #  income_expenditure_rating text,
    #  created_at timestamp with time zone,
    #  updated_at timestamp with time zone
    # );"
  end
  def down
    execute "DROP TABLE Users CASCADE;"
    # execute "DROP TABLE Statement_Transactions CASCADE;"
    execute "DROP TABLE User_Statements CASCADE;"
    # execute "DROP TABLE User_Income_Statistics CASCADE;"
  end
end
