class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.boolean :completed, default: false
      t.integer :position, default: nil
      t.integer :comments_count, default: 0
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
