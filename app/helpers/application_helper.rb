module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title="")
    base_title = "MNISHIGUCHI"

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # collection: an array of objects
  # prop:       attribute
  def list_tag(collection, prop)
    content_tag(:ul) do
      collection.each do |elem|
        concat content_tag(:li, elem.send(prop))
      end
    end
  end
end
