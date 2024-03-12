class SingleMigrationForAllTables < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false, primary_key: :name do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.boolean :verified, default: false, null: false
      t.string :default_task_group_name, default: "Default", null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :email, unique: true

    create_table :task_groups, id: false, primary_key: %i[ name user_name ] do |t|
      t.string :name, null: false
      t.string :user_name, null: false
      t.text :description

      t.timestamps
    end
    add_index :task_groups, [:name, :user_name], unique: true

    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.tsrange :during_time
      t.string :group_name, null: false
      t.string :user_name, null: false
      t.boolean :private, null: false, default: false
      t.boolean :done, null: false, default: false
    end

    add_foreign_key :task_groups, :users, column: :user_name, primary_key: :name, on_delete: :cascade, on_update: :cascade

    add_foreign_key :tasks, :task_groups, column: [:group_name, :user_name], primary_key: [:name, :user_name], on_delete: :cascade, on_update: :cascade
  end
end
