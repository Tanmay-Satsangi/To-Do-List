class Task < ApplicationRecord
    validates :title, presence: true

    def self.ransackable_attributes(auth_object = nil)
        [ "created_at", "id", "title", "updated_at" ]
    end

    enum :priority, { high: "high", medium: "medium", low: "low" }
end
