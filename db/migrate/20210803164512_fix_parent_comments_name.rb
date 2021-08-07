# frozen_string_literal: true

class FixParentCommentsName < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment_id, :parent_id
  end
end
