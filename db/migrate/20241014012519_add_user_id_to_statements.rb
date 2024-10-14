class AddUserIdToStatements < ActiveRecord::Migration[8.0]
  def up
    execute "ALTER TABLE Statements ADD COLUMN user_id integer references Users(id);"
  end
  def down
    execute "ALTER TABLE Statements DROP COLUMN user_id;"
  end
end
