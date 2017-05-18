class CreateCommentsTable < ActiveRecord::Migration[5.1]
  def change
  	create_table :comments do |t|
  		t.string :comment
  		t.integer :user_id
  		t.integer :blog_id
  	end
  end
end
