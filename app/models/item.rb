class Item < ActiveRecord::Base
  belongs_to :user
  has_many :loans
  has_many :borrowers, through: :loans, source: "user"

  acts_as_taggable_on :tags, :types

  state_machine :initial => :available do

    event :request_event do
      transition :available => :requested
    end

    event :deny_event do
      transition :requested => :available
    end

    event :loan_event do
      transition :requested => :borrowed
    end

    event :return_event do
      transition :borrowed => :available
    end

  end

end
