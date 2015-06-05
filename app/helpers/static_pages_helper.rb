module StaticPagesHelper

  # Returns the Gravatar image tag for the given email.
  def gravatar_for(email, options = { size: 80 })
    # Standardizing on all lower-case addresses
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: email, class: "gravatar img-thumbnail")
  end
end
