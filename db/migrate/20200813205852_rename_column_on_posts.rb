class RenameColumnOnPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.rename :descripton, :description
    end
  end
end
