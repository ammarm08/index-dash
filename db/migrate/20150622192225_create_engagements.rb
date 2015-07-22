class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.integer :stat
      t.string :date

      t.timestamps null: false
    end
  end
end
