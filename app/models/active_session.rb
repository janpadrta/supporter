# == Schema Information
#
# Table name: active_sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_agent :string
#  ip_address :string
#
class ActiveSession < ApplicationRecord
  belongs_to :user
end
