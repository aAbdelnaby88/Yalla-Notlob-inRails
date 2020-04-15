class Group < ApplicationRecord
  validates :name,presence: true, :uniqueness => {:case_sensitive => false,:scope => :user_id}
  belongs_to :user
  has_and_belongs_to_many :users


  def as_json(options={})
    super(options.merge methods: :user_json)
  end

  def user_json
    users.map do |user|
      user.to_json
    end
  end
  
end
