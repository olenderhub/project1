class CreateCommments < ActiveRecord::Migration
  def change
    create_table :commments do |t|
      t.string :podcommenter
      t.string :podtitle
      t.text :podbody
      t.references :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :commments, :comments
  end
end
