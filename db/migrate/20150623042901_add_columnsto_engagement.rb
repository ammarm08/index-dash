class AddColumnstoEngagement < ActiveRecord::Migration
  def change
  	add_column "engagements", :total, :integer
  	add_column "engagements", :from_followers, :integer
  end
end
