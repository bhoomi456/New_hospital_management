class AddPhoneToPatients < ActiveRecord::Migration[8.1]
  def change
    add_column :patients, :phone, :string
  end
end
