class Publication < ApplicationRecord
  has_one_attached :image

  # Validations
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :category, presence: true, inclusion: { in: %w[News Blog Article Research], message: "%{value} is not a valid category" }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  # Image validation
  validate :image_format_and_size

  private

  def image_format_and_size
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/jpg'))
        errors.add(:image, :content_type)  # Rails will automatically look for the message in the translations
      elsif image.byte_size > 5.megabytes
        errors.add(:image, :size)  # Rails will use the translated message for size
      end
    else
      errors.add(:image, :blank)  # Rails will use the translated message for blank
    end
  end
end
