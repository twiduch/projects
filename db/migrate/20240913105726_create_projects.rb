class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_enum :project_status, ["planned", "started", "paused", "review", "completed", "canceled"]

    create_table :projects, id: :uuid do |t|
      t.string :name
      t.enum :status, enum_type: "project_status", null: false, default: :planned

      t.timestamps
    end
  end
end
