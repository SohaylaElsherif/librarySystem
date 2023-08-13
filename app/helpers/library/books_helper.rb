module Library
  module BooksHelper
    def filter_and_sort_books(filter_params)
      filter_by = Book.ransack(filter_params)

      books = if filter_params.present?
        categories = filter_params[:categories_in].split(',') if filter_params[:categories_in].present?

        filtered_books = filter_by.result.includes(:categories, :shelf)

        filtered_books = filter_books_by_locale(filtered_books, filter_params[:locale])
        filtered_books = filter_books_by_categories(filtered_books, categories)

        filtered_books = case filter_params[:sort_by]
                         when 'highest_rated'
                           sort_books_by_highest_rated(filtered_books)
                         when 'lowest_rated'
                           sort_books_by_lowest_rated(filtered_books)
                         else
                           filtered_books.order(:position)
                         end

        paginate_books(filtered_books, filter_params[:page], filter_params[:per_page])
      else
        Book.includes(:categories, :shelf).order(:position).page(filter_params[:page]).per(filter_params[:per_page])
      end

      books_with_localization(books, filter_params[:locale])
    end

    private

    def filter_books_by_locale(books, locale)
      if locale == 'ar'
        books.with_title_locale(:ar).or(books.with_author_locale(:ar))
      else
        books.with_title_locale(:en).or(books.with_author_locale(:en))
      end
    end

    def filter_books_by_categories(books, categories)
      categories.present? ? books.joins(:categories).merge(Category.where(id: categories)) : books
    end

    def sort_books_by_highest_rated(books)
      books.joins(:reviews).group(:id).order('AVG(reviews.rating) DESC')
    end

    def sort_books_by_lowest_rated(books)
      books.joins(:reviews).group(:id).order('AVG(reviews.rating) ASC')
    end

    def paginate_books(books, page, per_page)
      books.page(page).per(per_page)
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
      record.send("#{attribute}_locale", locale.to_sym)
    end

    def localized_categories(categories, locale)
      categories.map { |category| category.name_locale(locale.to_sym) }
    end

    def calculate_rating(reviews)
      return 0 if reviews.empty?

      (reviews.sum(:rating) / reviews.count.to_f) * 5
    end
  end


  def calculate_rate_and_review_count
    self.reviewscount = reviews.count
    self.rating = (reviews.sum(:rating) / reviewcount.to_f) * 5 unless reviewcount.zero?
    save
  end
 def ensure_shelf_limit
    errors.add(:shelf_id, "no space") if self.class.where(shelf_id: self.shelf_id).where.not(id: self.id).count >= 5
  end

  def self.ransackable_attributes(auth_object = nil)
    ["author", "available", "created_at" , "id" , "title" , "updated_at", "position" ,"localized_title","localized_author" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["borrow_histories", "book_categories", "reviews", "shelf" ,"categories"]
  end
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :shelf_id, :category_ids, :available, :rating)
    end
end