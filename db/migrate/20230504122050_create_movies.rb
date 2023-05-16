class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string   :name
      t.integer  :read_count, null: false, default: 0
      # t.integer  :cast_id
      t.string   :year
      t.text     :overview
      # t.integer  :genre_id 
      t.string   :genre_name
      t.string   :image
      t.string   :runtime

      t.timestamps
    end
  end
end
