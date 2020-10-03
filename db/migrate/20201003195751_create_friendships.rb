class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :member, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :members }

      t.timestamps
    end
  end
end
