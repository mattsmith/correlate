class AddCorrelationToRelated < ActiveRecord::Migration
  def change
    add_column :relateds, :correlation, :float
  end
end
