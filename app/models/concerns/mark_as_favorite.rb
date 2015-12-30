module MarkAsFavorite
  extend ActiveSupport::Concern
  include CurrentUserAware

  def favorite?
    Favorite.where(model_class: self.class.to_s, model_id: self.id, user_id: current_user.id).count == 1
  end

  def toggle_favorite!
    if favorite?
      unmark_as_favorite!
    else
      mark_as_favorite!
    end
  end

  def mark_as_favorite!
    Favorite.create model_class: self.class.to_s, model_id: self.id, user_id: current_user.id
  end

  def unmark_as_favorite!
    Favorite.where(model_class: self.class.to_s, model_id: self.id, user_id: current_user.id).destroy_all
  end
end
