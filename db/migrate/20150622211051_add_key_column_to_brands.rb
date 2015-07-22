class AddKeyColumnToBrands < ActiveRecord::Migration
  def change
  	add_column "brands", :index_id, :integer
  end
end
