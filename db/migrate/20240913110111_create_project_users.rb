class CreateProjectUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :project_users, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :project, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
