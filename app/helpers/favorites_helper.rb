module FavoritesHelper
  def favorite_widget(model, favorite_path)
    link_options = {
      "href"        => favorite_path,
      "data-method" => :patch,
      "data-remote" => true,
      "class"       => 'marking-favorite'
    }
    span_options = {
      "aria-hidden" => true,
      "class"       => "favorite glyphicon glyphicon-heart #{glyph_class_for_favoriting(model)}"
    }
    content_tag('a', link_options) do
      content_tag('span', "", span_options)
    end
  end

  def glyph_class_for_favoriting(model)
    model.favorite? ? 'text-success' : 'text-muted'
  end
end
