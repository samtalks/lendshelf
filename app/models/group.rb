class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def members
    self.memberships.where.not(:state => 'pending')
  end

  def pending_members
    self.memberships.where(:state => "pending")
  end

end
