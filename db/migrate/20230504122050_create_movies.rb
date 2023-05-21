class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string   :name
      t.integer  :read_count, null: false, default: 0
      t.string   :year
      t.text     :overview
      t.string   :genre_name
      t.string   :image
      t.string   :runtime

      t.timestamps
    end
  end
end
