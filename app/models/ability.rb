class Ability
		include CanCan::Ability

def initialize(user)
	user ||= User.new

	if user.is_admin?
		can :manage, Image
	end


end

end