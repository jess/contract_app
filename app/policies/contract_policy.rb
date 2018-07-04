class ContractPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.contracts
    end
  end

  def manage?
    user.contracts.include?(record)
  end
end
