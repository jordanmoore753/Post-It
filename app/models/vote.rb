class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  before_create :one_vote

  validates :vote, inclusion: { in: [true, false] }

  def one_vote
    !Vote.find_by(user_id: creator, voteable: voteable, vote: vote) &&
    !Vote.find_by(user_id: creator, voteable: voteable, vote: !vote)
  end
end