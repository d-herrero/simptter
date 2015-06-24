class User < ActiveRecord::Base
  self.table_name = 'simptter_users'

  has_many :messages, :dependent => :destroy
  has_many :followers, :class_name => 'UserRelation', :foreign_key => 'following_id', :dependent => :destroy
  has_many :followings, :class_name => 'UserRelation', :foreign_key => 'user_id', :dependent => :destroy

  devise :database_authenticatable, :rememberable, :trackable, :registerable

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  validates :name, login: true
  validates :password, password: true
  validates :email, email: true
end