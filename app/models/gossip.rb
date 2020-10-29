class Gossip < ApplicationRecord
    validates :title, presence: true, length: {minimum: 3, maximum: 14}
    validates :content, presence: true
    has_many :tags, through: :gossip_tags
    has_many :comments
    belongs_to :user
end