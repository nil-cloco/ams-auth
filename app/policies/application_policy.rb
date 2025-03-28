class ApplicationPolicy
    attr_reader :user, :record
  
    def initialize(user, record)
      @user = user
      @record = record
    end
  
    def scope
      Pundit.policy_scope!(user, record.class)
    end

    def index?
        false
    end
  
    def show?
      false
    end
  
    def create?
      false
    end
  
    def update?
      false
    end
  
    def destroy?
      false
    end
  end
  