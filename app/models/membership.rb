class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  state_machine :initial => :pending do

    event :approve_member do
      transition :pending => :member
    end

    event :make_admin do
      transition :member => :admin
    end

    event :make_owner do
      transition [:member, :admin] => :owner
    end

  end
end
