# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#AdminUser.create!(email: 'admin__samr@yahoo.com', password: '123456', password_confirmation: '123456') if Rails.env.development?
require 'rest-client'
require 'json'
require 'faker'

# Define a method to fetch data from the Open Library API
def fetch_data(url)
  response = RestClient.get(url)
  JSON.parse(response.body)
end



open_library_url = 'https://openlibrary.org/subjects/Fiction.json'
book_data = fetch_data(open_library_url)

# Create sample Book records from the API data
books_data = book_data['works'].first(5).map do |work|
  {
    title: work['title'],
    author: work['authors'][0]['name'],
    shelf: shelves.sample,
    available: true,
    position: rand(1..100),
    rating: rand(1..5),
    category: categories.sample
  }
end
books = Book.create!(books_data)

# Seed data for mobility_string_translations
string_translations_data = books.flat_map do |book|
  [
    {
      locale: 'en',
      key: 'title',
      value: "Translated Title for #{book.title}",
      translatable_type: 'Book',
      translatable_id: book.id
    },
    {
      locale: 'ar',
      key: 'title',
      value: "العنوان المترجم لـ #{book.title}",
      translatable_type: 'Book',
      translatable_id: book.id
    }
  ]
end
MobilityStringTranslation.create!(string_translations_data)

text_translations_data = books.map do |book|
  {
    locale: 'en',
    key: 'description',
    value: Faker::Lorem.paragraph,
    translatable_type: 'Book',
    translatable_id: book.id
  }
end
MobilityTextTranslation.create!(text_translations_data)

users_data = (1..7).map do |i|
  {
    email: "user#{i}@example.com",
    password: 'password',
    dateOfBirth: Faker::Date.between(from: '1980-01-01', to: '2000-12-31'),
  }
end
users = User.create!(users_data)
borrow_histories_data = users.flat_map do |user|
  books.sample(3).map do |book|
    {
      user: user,
      book: book,
      borrow_date: Date.today - rand(1..5),
      return_date: Date.today - rand(6..12),
      status: rand(0..1)
    }
  end
end
BorrowHistory.create!(borrow_histories_data)

reviews_data = []
users.each do |user|
  books.sample(3).each do |book|
    reviews_data << {
      user: user,
      book: book,
      rating: rand(1..5),
      comment: Faker::Lorem.paragraph,
      review_type: 'user_book'
    }
  end
end
Review.create!(reviews_data)
