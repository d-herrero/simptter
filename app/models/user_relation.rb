class UserRelation < ActiveRecord::Base
  self.table_name = 'simptter_users_relations'

  belongs_to :user
  belongs_to :following, :class_name => 'User', :foreign_key => 'following_id'
end