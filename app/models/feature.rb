# == Schema Information
#
# Table name: features
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string(255)
#  instructions :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Feature < ActiveRecord::Base
  attr_accessible :instructions, :name
  belongs_to :user, :inverse_of => :features
  has_and_belongs_to_many :targets

  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 4, maximum: 25 }
  validates :instructions, presence: true
end
