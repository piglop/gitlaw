class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if current_user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
    end
  end
end
