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

  # return the Gravatar image tag for the given user
  def gravatar_for(email, options = { size: 80 })
    # standardize on all lower-case addresses
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: email, class: "gravatar")
  end
end
