class RemoveAdminEmailAndAddressFromHospitals < ActiveRecord::Migration[8.1]
  def change
    remove_column :hospitals, :admin_email, :string
    remove_column :hospitals, :address, :text
  end
end
