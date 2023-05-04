class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string   :name
      t.integer  :read_count
      t.string   :cast
      t.string   :year
      t.text     :overview
      t.integer  :genre_id 

      t.timestamps
    end
  end
end
