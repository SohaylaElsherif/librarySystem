# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@yahoo.com', password: '123456', password_confirmation: '123456') if Rails.env.development?
Category.create(name: "Fiction")
Category.create(name: "Science Fiction")
Category.create(name: "Fantasy")
Category.create(name: "Mystery")
fiction_category = Category.find_by(name: "Fiction")
science_fiction_category = Category.find_by(name: "Science Fiction")
Shelf.create(number_of_books: 1)

Book.create(title: "Book 1", author: "Author 1", shelf: Shelf.first, category_1_id: fiction_category.id)
Book.create(title: "Book 2", author: "Author 2", shelf: Shelf.first, category_1_id: science_fiction_category.id)
Book.create(title: "Book 3", author: "Author 3", shelf: Shelf.first, category_1_id: fiction_category.id)
Book.create(title: "Book 4", author: "Author 4", shelf: Shelf.first, category_1_id: fiction_category.id)
books_data = [
  { title: 'Title 1', author: 'Author 1', shelf_id: 1, category_1_id: 1, category_2_id: 2, category_3_id: 3, available: true, position: 1 },
  { title: 'Title 2', author: 'Author 2', shelf_id: 2, category_1_id: 3, category_2_id: 2, category_3_id: 1, available: false, position: 2 },
  # Add more book data here as needed
]

books_data.each do |book_params|
  Book.create(book_params)
end
