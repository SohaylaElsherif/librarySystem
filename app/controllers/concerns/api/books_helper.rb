module Api
  module BooksHelper
#    def filter_and_sort_books(filter_params)
#      filter_by = Book.ransack(filter_params)

#      books = if filter_params.present?
#        categories = filter_params[:categories_in].split(',') if filter_params[:categories_in].present?

#        filtered_books = filter_by.result.includes(:categories, :shelf)

#        filtered_books = filter_books_by_locale(filtered_books, filter_params[:locale])
#        filtered_books = filter_books_by_categories(filtered_books, categories)
#
#        filtered_books = case filter_params[:sort_by]
#                         when 'highest_rated'
#                           sort_books_by_highest_rated(filtered_books)
#                         when 'lowest_rated'
#                           sort_books_by_lowest_rated(filtered_books)
#                         else
#                           filtered_books.order(:position)
#                         end

#        paginate_books(filtered_books, filter_params[:page], filter_params[:per_page])
#      else
#        Book.includes(:categories, :shelf).order(:position).page(filter_params[:page]).per(filter_params[:per_page])
#      end

#      books_with_localization(books, filter_params[:locale])
#    end
def filter_and_sort_books(params)
  books = Book.includes(:categories, :shelf)

  if params[:filter_by].present?
    filters = params[:filter_by]
    books = apply_filters(books, filters)
  end

  if params[:sort_by].present?
    sort_param = params[:sort_by]
    books = apply_sorting(books, sort_param)
  end

  books.page(params[:page]).per(params[:per_page])
end

def apply_filters(books, filters)
  filtered_books = books

  filtered_books = filtered_books.with_title(filters[:title_i18n]) if filters[:title_i18n].present?
  filtered_books = filtered_books.with_author(filters[:author_i18n]) if filters[:author_i18n].present?
  
  if filters[:categories_in].present?
    categories = filters[:categories_in].split(',')
    filtered_books = filtered_books.joins(:categories).merge(Category.where(id: categories))
  end

  filtered_books = filtered_books.where(shelf_id: filters[:shelf_id]) if filters[:shelf_id].present?

  filtered_books
end

def apply_sorting(books, sort_param)
  case sort_param
  when 'highest_rated'
    books.order(rating: :desc)
  when 'lowest_rated'
    books.order(rating: :asc)
  else
    books.order(:position)
  end
end

def books_with_localization(books, locale)
  books.map do |book|
    {
      id: book.id,
      title: localize_attribute(book, :title, locale),
      author: localize_attribute(book, :author, locale),
      categories: localized_categories(book.categories, locale),
      review_count: book.reviews.count,
      rating: calculate_rating(book.reviews)
    }
  end
end

def localize_attribute(record, attribute, locale)
  record.send("title_#{locale}") if attribute == :title
  record.send("author_#{locale}") if attribute == :author
end

def localized_categories(categories, locale)
  categories.map { |category| category.name_locale(locale) }
end

def calculate_rating(reviews)
  return 0 if reviews.empty?

  (reviews.sum(:rating) / reviews.count.to_f) * 5
end

  def calculate_rate_and_review_count
    self.reviewscount = reviews.count
    self.rating = (reviews.sum(:rating) / reviewcount.to_f) * 5 unless reviewcount.zero?
    save
  end



    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :shelf_id, :category_ids, :available, :rating)
    end
  end
end