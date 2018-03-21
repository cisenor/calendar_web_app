Hanami::Model.migration do
  change do
    create_table :calendar_entries do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :name, String, null: false
      column :month, Integer, null: false
      column :day, Integer, null: true
      column :occurrence_week, Integer, null: true
      column :occurrence_weekday, Integer, null: true
    end
  end
end
