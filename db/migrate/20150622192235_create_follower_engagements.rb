class CreateFollowerEngagements < ActiveRecord::Migration
  def change
    create_table :follower_engagements do |t|
      t.integer :stat
      t.string :date

      t.timestamps null: false
    end
  end
end
