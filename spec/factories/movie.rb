FactoryBot.define do
  factory :movie do
    name { "Example Movie" }
    read_count { 0 }
    year { "2023" }
    overview { "This is an example movie." }
    genre_name { "Action" }
    image { "example.jpg" }
    runtime { "120 minutes" }
  end
end