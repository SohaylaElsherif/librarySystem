class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.has_role?(:admin)
      can :manage, :all
    elsif user&.has_role?(:member)
      can :read, Book
    end
  end
end
