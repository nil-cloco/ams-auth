# app/policies/application_policy.rb
class ApplicationPolicy
    attr_reader :user, :record
  
    def initialize(user, record)
      @user = user
      @record = record
    end
  
    # Define a default "scope" for the model records
    def scope
      Pundit.policy_scope!(user, record.class)
    end

    def index?
        false
    end
  
    # Default rule for show and other actions
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

    def import?
      false
    end

    def export?
      false
    end
  end
  