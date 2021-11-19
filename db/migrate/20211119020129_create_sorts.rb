class CreateSorts < ActiveRecord::Migration[6.1]
  def change
    create_table :sorts do |t|
      t.string :word
      t.string :sorting_method

      t.timestamps
    end
  end
end
