class RemoveDownvoteFromUpvotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :downvote, :integer
  end
end
