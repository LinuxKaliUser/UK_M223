class Post < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
      
    before_save :set_slug
      
    def set_slug
        self.slug = title.parameterize
        #Url maschine format convert human format
    end

    def published?
        published_at.present? && published_at <= Time.current
    end
        # ...
      
end
