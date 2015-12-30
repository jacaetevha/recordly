class Record < ActiveRecord::Base
  include MarkAsFavorite

  paginates_per 10
  max_paginates_per 50

  has_and_belongs_to_many :artists
  has_many :songs, dependent: :delete_all

  validates :title, presence: true, length: { minimum: 1 }
  validates :user_id, presence: true, numericality: { only_integer: true }

  before_save :set_ordinal_letter

  def set_ordinal_letter
    words = title.downcase.split.reject{|e| e == 'the' || e == 'a' || e == 'an'}
    self.ordinal_letter = words.empty? ? title[0].downcase : words.first[0]
  end
end
