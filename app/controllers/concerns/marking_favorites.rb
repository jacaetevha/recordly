module MarkingFavorites
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token, only: :favorite
  end

  # PATCH /:model/:id.js
  # PATCH /:model/:id.json
  def favorite
    @model = model
    @model.toggle_favorite!
    respond_to do |format|
      format.json { render template: "#{@model.class}/show", formats: [:json], handlers: ["jbuilder"] }
      format.js { render nothing: true }
      format.html { redirect_to 'errors/not_acceptable' }
    end
  end

  def model
    raise NotImplementedError, 'including class should define this'
  end
end
