class CreateCastsMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :casts_movies do |t|
      t.integer  :movie_id
      t.integer  :cast_id

      t.timestamps
    end
  end
end
