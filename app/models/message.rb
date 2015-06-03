class Message < ActiveRecord::Base
  self.table_name = 'simptter.messages'

  belongs_to :user

  # I prefer to have presence and lenght validations separated, so AR doesn't show
  # "minimum is 1 character" when the field it's empty
  validates_presence_of :text
  validates_length_of :text, :maximum => 160, :allow_blank => true
end