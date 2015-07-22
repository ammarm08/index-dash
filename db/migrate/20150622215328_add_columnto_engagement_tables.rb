class AddColumntoEngagementTables < ActiveRecord::Migration
  def change
  	add_column "engagements", :brand_id, :integer
  	add_column "follower_engagements", :brand_id, :integer
  end
end
