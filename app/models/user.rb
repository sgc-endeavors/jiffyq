class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :terms#, :is_admin
  validates :terms, :acceptance => {:accept => true}

  # attr_accessible :title, :body
  has_many :polls#, :dependent => :destroy
  has_many :images#, :dependent => :destroy
  has_many :favorites, :dependent => :destroy


  def total_views
    total_views = 0
    for poll in self.polls
      total_views += poll.page_views.to_i
    end
    return total_views
  end






end
