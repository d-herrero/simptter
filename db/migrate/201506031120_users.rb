class Users < ActiveRecord::Migration
  def self.up
    execute 'CREATE SCHEMA simptter'

    create_table 'simptter.users' do |t|
      t.string :name, :null => false
      t.timestamps
      # DEVISE
      # Database authenticatable
      t.string :email, :null => false, :default => String.new
      t.string :encrypted_password, :null => false, :default => String.new
      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      # Rememberable
      t.datetime :remember_created_at
      # Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    add_index 'simptter.users', :email, :unique => true
    add_index 'simptter.users', :reset_password_token, :unique => true
  end

  def self.down
    drop_table 'simptter.users'
    execute 'DROP SCHEMA simptter'
  end
end