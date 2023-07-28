# librarySystem
This repository contains the backend API for a comprehensive library management system built using Ruby on Rails. The API provides a robust set of endpoints to manage books, users, borrowing, book reviews, and more.
## Features:

### User Authentication: 
Implements user registration, login, and logout with Devise gem. JWT (JSON Web Token) is used for secure authorization.
### Book Management: 
Allows CRUD (Create, Read, Update, Delete) operations for books. Books can be filtered, sorted, and reordered based on various attributes.
### Attribute Localization:
Uses Mobility and Mobility-Ransack to support localization of book names, author names, and category names.
### JSON:API Serialization: 
Provides JSON:API compliant serialization for API responses.
### Borrowing and Book Return: 
Handles book borrowing and return processes with due date notifications and reminders using Sidekiq for background jobs.
### Book Reviews:
Enables users to write reviews and rate books. Prevents duplicate reviews for the same book by the same user.
### Admin Interface:
Includes ActiveAdmin for a user-friendly admin dashboard to manage books, users, and admin users efficiently.
### Pagination: 
Implements pagination with Kaminari for book listings to enhance API performance.
### Sorting and Reordering: 
Uses ActsAsList to allow custom sorting and reordering of books on shelves.
### Localization: 
Supports internationalization with customizable date and time formatting using DateTime's strftime.
### PostgreSQL:
 Utilizes PostgreSQL as the database for efficient data storage and retrieval.
### Testing:
The API functionalities are thoroughly tested using a comprehensive Postman collection to ensure proper functioning and to handle different scenarios.
