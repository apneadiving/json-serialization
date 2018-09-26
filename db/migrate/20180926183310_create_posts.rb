class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :full_name
      t.text :body
      t.text :summary
      t.timestamps
    end
  end
end
