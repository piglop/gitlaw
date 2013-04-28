class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if user and user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      cannot :read, User
      can [:create, :compare_with_base, :update], Constitution
    end
  end
end
