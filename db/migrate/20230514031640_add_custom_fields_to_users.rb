class AddCustomFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :city_name, :string
    add_column :users, :school_name, :string
    add_column :users, :level_name, :string
    add_column :users, :class_name, :string
    add_column :users, :matricule, :string
    add_column :users, :contact, :string
    add_column :users, :doublant, :boolean
    add_column :users, :gender, :string
    add_column :users, :referral_code, :string
  end
end
