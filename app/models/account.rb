class Account < ActiveRecord::Base
  monetize :balance_cents

  #I had to do the following to rescute the controller from issue
  #commeted out after issue resolved
  #self.inheritance_column = :_type_disabled

  def self.types
    Asset.types # + Liability.types
  end
end
