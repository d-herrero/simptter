class Messages < ActiveRecord::Migration
  def self.up
    create_table 'simptter_messages' do |t|
      t.string :text, :null => false
      t.timestamp :date_time, :null => false
      t.references :user, :null => false
    end
  end

  def self.down
    drop_table 'simptter_messages'
  end
end
