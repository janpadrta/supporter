# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Team < ApplicationRecord
	has_many :users

	def self.ransackable_attributes(auth_object = nil)
    ["id", "id_value", "name"]
  end

  def print_leader
		return self.users.leader.map{ |u| u.name }.join(',    ') if self.users.leader.exists?
		''
  end
end
