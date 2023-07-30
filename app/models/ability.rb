class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user.admin?
     can :manage, :all
      cannot :edit, Review
      cannot :update, Review
      cannot :create, Review
      cannot :destroy, Review

      cannot :create, BorrowHistory
      can :edit, BorrowHistory
      can :update, BorrowHistory
      cannot :destroy, BorrowHistory



      can :manage, Book, shelf_id: user.available_shelf_ids
      can :manage, BorrowHistory
      can :create, Book, shelf_id: Shelf.where('number_of_books < ?', 5).pluck(:id)

     can :create, Category
      can :edit, Category
      can :update, Category
      can :destroy, Category

      can :destroy, User

      can :read, namespace_name: "api"

     return if user.present?
      can :read, Book
      can :create, BorrowHistory
      can :update, BorrowHistory
      can :edit, Review
      can :update, Review
      can :create, Review
      can :destroy, Review

  end
end
