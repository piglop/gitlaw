class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if user and user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :compare, Modification
      
      if user
        can [:create, :update], Text, user_id: user.id
        can [:create, :update], Modification, user_id: user.id
      end
    end
  end
end
