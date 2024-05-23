class AddRolesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :technical, :boolean, default: false
    add_column :users, :team_leader, :boolean, default: false
    add_column :users, :approver, :boolean, default: false
  end
end
