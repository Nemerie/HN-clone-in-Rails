class AddPointsToPostsAndComments < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :points, :integer, default: 1
    add_column :comments, :points, :integer, default: 0
  end
end
