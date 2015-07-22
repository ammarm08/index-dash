class AddIndexToEngagement < ActiveRecord::Migration
  def change
  	add_index "engagements", ["id"], name: "index_engagements_on_id", unique: true
  end
end
