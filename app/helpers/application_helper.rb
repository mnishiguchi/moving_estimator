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
    image_tag(gravatar_url, alt: email, class: "gravatar img-thumbnail img-responsive center-block")
  end

  def placehold_img_tag(options={})
    opts = { dimension: "350x150", background_color: "ccc", text_color: "555", text: ""}.merge(options)
    image_tag("https://placehold.it/#{opts[:dimension]}/#{opts[:background_color]}/#{opts[:text_color]}?text=#{opts[:text].tr(" ", "+")}")
  end
end
