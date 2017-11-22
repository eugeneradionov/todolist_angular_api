class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.string :attachment
      t.references :task, foreign_key: true
    end
  end
end
