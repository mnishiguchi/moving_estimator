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
  def list_for(collection, prop)
    content_tag(:ul) do
      collection.each do |elem|
        concat content_tag(:li, elem.send(prop))
      end
    end
  end

  # A table for key-value pairs
  # columns:    an array of header strings
  # collection: a hash
  def kv_table_for(columns=[], collection={})
    thead = content_tag(:thead) do
      content_tag(:tr) do
        # generating <th>table headers</th>
        tags = columns.map { |column| content_tag(:th, column, class: "text-center") }
        safe_join tags
      end
    end

    tbody = content_tag(:tbody) do
      # generating <td>table data</td>
      tags = collection.map { |k, v|
        content_tag(:tr, class: "text-center") do
          content_tag(:td, k) +
          content_tag(:td, v)
        end
      }
      safe_join tags
    end

    content_tag(:div, class: "table-responsive") do
      content_tag(:table, class: "table table-bordered table-hover table-striped") do
        thead + tbody
      end
    end
  end
end
