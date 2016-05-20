class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
      # add_index :comments, :post_id
    end
  end
end
