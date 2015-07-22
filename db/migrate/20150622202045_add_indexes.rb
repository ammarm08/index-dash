class AddIndexes < ActiveRecord::Migration
  def change
  	add_index "indices", ["name"], name: "index_indices_on_name", unique: true
  	add_index "brands", ["name"], name: "index_brands_on_name", unique: true
  end
end
