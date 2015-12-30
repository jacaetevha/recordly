class Song < ActiveRecord::Base
  include MarkAsFavorite

  belongs_to :record
  default_scope -> { order :ordinal }

  before_create -> (song) { song.ordinal ||= 1 }
  after_save :reorder

  validates :title, presence: true, length: { minimum: 1 }
  validates :record_id, presence: true, numericality: { only_integer: true }, on: :create
  validate :record_id_not_changed, on: :update

private

  def reorder
    # This algorithm relies on natural ordering. By putting myself at the front of the line
    # and then reordering by "ordinal", I'm guaranteed to come before any other song on my
    # record that has the same "ordinal" as me.
    _songs = record.songs.to_a
    _my_index = _songs.index(self)
    _songs.delete_at _my_index
    _songs.unshift self
    _songs.sort_by(&:ordinal).each_with_index do |s, index|
      s.update_column :ordinal, index + 1
    end
  end

  def record_id_not_changed
    if record_id_changed? && self.persisted?
      errors.add(:record_id, "Change of record_id not allowed!")
    end
  end
end
