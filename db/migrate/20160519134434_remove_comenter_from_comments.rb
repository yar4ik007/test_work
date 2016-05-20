class RemoveComenterFromComments < ActiveRecord::Migration
  def change
	remove_column(:comments, :commenter)
  end
end
