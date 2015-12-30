module MarkAsFavorite
  extend ActiveSupport::Concern

  def favorite?(user)
    Favorite.where(model_class: self.class.to_s, model_id: self.id, user_id: user.id).count == 1
  end

  def toggle_favorite!(user)
    if favorite?(user)
      unmark_as_favorite!(user)
    else
      mark_as_favorite!(user)
    end
  end

  def mark_as_favorite!(user)
    Favorite.create model_class: self.class.to_s, model_id: self.id, user_id: user.id
  end

  def unmark_as_favorite!(user)
    Favorite.where(model_class: self.class.to_s, model_id: self.id, user_id: user.id).destroy_all
  end
end
