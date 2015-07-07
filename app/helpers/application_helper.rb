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

  # Returns the Gravatar image tag for the given email.
  def gravatar_for(email, options = { size: 80 })
    # Standardizing on all lower-case addresses
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: email, class: "gravatar img-thumbnail")
  end

  # A list for all the items of the specified attribute of the object.
  # collection: an array of objects
  # prop:       attribute
  def list_for(collection, prop)
    content_tag(:ul) do
      collection.each do |elem|
        concat content_tag(:li, elem.send(prop))
      end
    end
  end

  # A table for key-value pairs.
  # kv_names:   an array of header strings
  # collection: a hash
  def kv_table_for(kv_names=[], collection={})
    thead = content_tag(:thead) do
      content_tag(:tr) do
        # generating <th>table headers</th>
        tags = kv_names.map { |column| content_tag(:th, column, class: "text-center") }
        safe_join tags
      end
    end

    tbody = content_tag(:tbody) do
      # generating <td>table data</td>
      tags = collection.map do |k, v|
        content_tag(:tr, class: "text-center") do
          concat content_tag(:td, k)
          concat content_tag(:td, v)
        end
      end
      safe_join tags
    end

    content_tag(:div, class: "table-responsive") do
      content_tag(:table, class: "table table-striped") do
        thead + tbody
      end
    end
  end
end
