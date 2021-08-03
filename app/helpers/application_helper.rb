module ApplicationHelper
  class List
    def each_in_tree_with_index
      return nil unless block_given?

      self.each
    end
  end
end
