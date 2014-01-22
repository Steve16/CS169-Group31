class AddFacebookIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string, :after => :email
  end
end
