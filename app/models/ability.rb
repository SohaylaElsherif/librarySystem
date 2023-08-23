class Ability
  include CanCan::Ability

  def initialize(user)

    return if user.admin?
     can :manage, :all
      cannot :edit, Review
      cannot :update, Review
      cannot :create, Review
      cannot :destroy, Review

      cannot :create, BorrowHistory
      can :edit, BorrowHistory
      can :update, BorrowHistory
      cannot :destroy, BorrowHistory

      can :manage, BookCategory


      can :manage, Book, shelf_id: user.available_shelf_ids
      can :manage, BorrowHistory
      can :create, Book, shelf_id: Shelf.where('number_of_books < ?', 5).pluck(:id)

     can :create, Category
      can :edit, Category
      can :update, Category
      can :destroy, Category
      can :read, all
      can :destroy, User

     return if user.present?
      can :read, Book
      can :create, BorrowHistory
      can :update, BorrowHistory
      can :edit, Review
      can :update, Review
      can :create, Review
      can :destroy, Review
      can :read, namespace_name: "api"

  end
end
