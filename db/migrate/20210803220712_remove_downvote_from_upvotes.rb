# frozen_string_literal: true

class RemoveDownvoteFromUpvotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :votes, :downvote, :integer
  end
end
