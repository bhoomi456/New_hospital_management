class AddAdminEmailAndAddressToHospitals < ActiveRecord::Migration[8.1]
  def change
    add_column :hospitals, :admin_email, :string, null: false
    add_column :hospitals, :address, :text
  end
end
