class AddForeignKeyToBeer < ActiveRecord::Migration
  def change

   add_foreign_key :beers, :styles
  end
end
