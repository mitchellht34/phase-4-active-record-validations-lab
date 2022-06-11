class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    # validates :category, inclusion: { in: ['Fiction', 'Non-Fiction'] }
    validate :is_sufficient_clickbait

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def is_sufficient_clickbait
        unless CLICKBAIT_PATTERNS.any?{ |pattern| pattern.match title }
            errors.add(:title, "must be more clickbait-y")
        end
    end
end
