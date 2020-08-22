class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
