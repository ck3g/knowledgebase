module SkillsHelper
  def links_to_tags(tags)
    tags.map do |tag_name|
      link_to "##{tag_name}", "#", :class => "tag-link"
    end.join(" ").html_safe
  end
end
