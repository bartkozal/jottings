module ApplicationHelper
  def gravatar_tag(email, size: 48)
    hash = Digest::MD5.hexdigest(email.downcase)
    image_tag(
      "https://www.gravatar.com/avatar/#{hash}?s=#{size * 2}",
      alt: "Avatar of #{email}",
      class: "img-circle",
      style: "width: #{size}px; height: #{size}px;"
    )
  end

  def icon_tag(name, *classes)
    css_classes = ["ion-#{name}"] << Array(classes)
    content_tag(:i, nil, class: css_classes)
  end
end
