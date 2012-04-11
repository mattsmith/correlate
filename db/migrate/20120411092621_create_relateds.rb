class CreateRelateds < ActiveRecord::Migration
  def change
    create_table :relateds do |t|
      t.references :user
      t.integer :paired_id
      t.integer :count

      t.timestamps
    end
    add_index :relateds, :user_id
  end
end
