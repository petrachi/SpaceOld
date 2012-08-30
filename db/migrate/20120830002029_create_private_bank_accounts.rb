class CreatePrivateBankAccounts < ActiveRecord::Migration
  def change
    create_table :private_bank_accounts do |t|
      t.integer :balance
      t.references :private_user

      t.timestamps
    end
    
    add_index :private_bank_accounts, :private_user_id
  end
end
