class UsersRelations < ActiveRecord::Migration
  def self.up
    create_table 'simptter.users_relations' do |t|
      t.references :user, :null => false
      t.integer :following_id, :null => false
    end
  end

  def self.down
    drop_table 'simptter.users_relations'
  end
end