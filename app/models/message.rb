class Message < ActiveRecord::Base
  self.table_name = 'simptter_messages'

  belongs_to :user

  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true
end