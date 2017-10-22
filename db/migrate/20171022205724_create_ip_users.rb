class CreateIpUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_users do |t|
      t.inet :ip
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
