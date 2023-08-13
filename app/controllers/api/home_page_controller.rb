module Api
  class HomePageController < BaseController
    def index
  api_endpoints = {
    "users": {
      "register_user": {
        "url": "http://localhost:3000/en/api/users/sign_up",
        "method": "POST",
        "description": "Register a new user",
        "request_body": {
          "user": {
            "email": "user@example.com",
            "password": "password",
            "password_confirmation": "password"
          }
        }
      },
      "login_user": {
        "url": "http://localhost:3000/api/users/sign_in",
        "method": "POST",
        "description": "Login a user",
        "request_body": {
          "user": {
            "email": "user@example.com",
            "password": "password"
          }
        }
      },
      "verify_otp": {
        "url": "http://localhost:3000/verify_otp",
        "method": "POST",
        "description": "Verify OTP for user registration",
        "request_body": {
          "user_email": "user@example.com",
          "otp_code": "123456"
        }
      },
      "reset_password": {
        "url": "http://localhost:3000/api/users/password",
        "method": "POST",
        "description": "Send reset password instructions",
        "request_body": {
          "user": {
            "email": "user@example.com"
          }
        }
      },
      "update_password": {
        "url": "http://localhost:3000/api/users/password",
        "method": "PATCH",
        "description": "Update user password using reset token",
        "request_body": {
          "user": {
            "reset_password_token": "reset_token",
            "password": "new_password",
            "password_confirmation": "new_password"
          }
        }
      },
      "logout_user": {
        "url": "http://localhost:3000/api/users/sign_out",
        "method": "DELETE",
        "description": "Logout a user"
      }
    },
    "api_v1": {
      "list_borrow_histories": {
        "url": "http://localhost:3000/api/v1/borrow_histories",
        "method": "GET",
        "description": "List borrow histories for current user"
      },
      "show_borrow_history": {
        "url": "http://localhost:3000/api/v1/borrow_histories/:id",
        "method": "GET",
        "description": "Show details of a borrow history for current user"
      },
      "create_borrow_history": {
        "url": "http://localhost:3000/api/v1/borrow_histories",
        "method": "POST",
        "description": "Create a new borrow history",
        "request_body": {
          "borrow_history": {
            "book_id": 1
          }
        }
      },
      "update_borrow_history": {
        "url": "http://localhost:3000/api/v1/borrow_histories/:id",
        "method": "PATCH",
        "description": "Update a borrow history",
        "request_body": {
          "borrow_history": {
            "status": "returned"
          }
        }
      },
      "delete_borrow_history": {
        "url": "http://localhost:3000/api/v1/borrow_histories/:id",
        "method": "DELETE",
        "description": "Delete a borrow history"
      },
      "create_review": {
        "url": "http://localhost:3000/api/v1/reviews",
        "method": "POST",
        "description": "Create a new review",
        "request_body": {
          "review": {
            "rating": 5,
            "comment": "Great book!"
          }
        }
      },
      "update_review": {
        "url": "http://localhost:3000/api/v1/reviews/:id",
        "method": "PATCH",
        "description": "Update a review",
        "request_body": {
          "review": {
            "rating": 4
          }
        }
      },
      "list_reviews": {
        "url": "http://localhost:3000/api/v1/reviews",
        "method": "GET",
        "description": "List reviews for current user"
      },
      "list_notifications": {
        "url": "http://localhost:3000/api/v1/notifications",
        "method": "GET",
        "description": "List notifications for current user"
      },
      "show_notification": {
        "url": "http://localhost:3000/api/v1/notifications/:id",
        "method": "GET",
        "description": "Show details of a notification for current user"
      }
    },
    "books": {
      "list_all_books": {
        "url": "http://localhost:3000/api/books",
        "method": "GET",
        "description": "List all books"
      },
      "show_book": {
        "url": "http://localhost:3000/api/books/:id",
        "method": "GET",
        "description": "Show details of a book"
      }
    },
    "home_page": {
      "home": {
        "url": "http://localhost:3000/",
        "method": "GET",
        "description": "Home page"
      }
    }
  }
  render json: api_endpoints
    end
  end
end
