module Library
  class HomePageController < BaseController
    def index
      api_endpoints = {
        books: {
          list_all_books_arabic: {
            url: "#{library_books_url}?locale=ar",
            method: 'GET',
            description: 'List all books in Arabic',
            request_body: nil
          },
          list_all_books_english: {
            url: "#{library_books_url}?locale=en",
            method: 'GET',
            description: 'List all books in English',
            request_body: nil
          },
          filter_by_name_highest_rated_arabic: {
            url: "#{library_books_url}?title=Sample&sort_by=highest_rated&locale=ar",
            method: 'GET',
            description: 'Filter by name and order by highest rated in Arabic',
            request_body: nil
          },
          filter_by_author_lowest_rated_english: {
            url: "#{library_books_url}?author=John&sort_by=lowest_rated&locale=en",
            method: 'GET',
            description: 'Filter by author and order by lowest rated in English',
            request_body: nil
          },
          filter_by_categories_and_shelf_arabic: {
            url: "#{library_books_url}?categories_in=1,2,3&shelf_id=1&locale=ar",
            method: 'GET',
            description: 'Filter by categories and shelf in Arabic',
            request_body: nil
          }
        }
        # Add more API endpoints here
      }

      render json: api_endpoints
    end
  end
end
