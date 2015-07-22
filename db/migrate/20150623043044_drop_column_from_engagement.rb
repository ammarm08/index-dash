class DropColumnFromEngagement < ActiveRecord::Migration
  def change
  	remove_column "engagements", :stat
  end
end
