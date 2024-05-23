# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string
#  password_digest       :string
#  password_confirmation :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  admin                 :boolean          default(FALSE)
#  technical             :boolean          default(FALSE)
#  team_leader           :boolean          default(FALSE)
#  approver              :boolean          default(FALSE)
#
class User < ApplicationRecord
  has_secure_password :password, validations: true
  validates :name, presence: true, uniqueness: true

  has_many :active_sessions, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["admin", "approver", "id", "id_value", "name", "team_leader", "technical"]
  end
  
end