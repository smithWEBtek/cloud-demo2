class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
			t.string :public_id
			t.string :url
			t.string :secure_url
			t.integer :width
			t.integer :height
			t.string :format
      t.timestamps
    end
  end
end
