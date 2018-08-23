class Version < ActiveRecord::Base
  validates :version, presence: true
end
