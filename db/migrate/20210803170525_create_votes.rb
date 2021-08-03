class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :votable, polymorphic: true
      t.integer :upvote
      t.integer :downvote

      t.timestamps
    end
  end
end
