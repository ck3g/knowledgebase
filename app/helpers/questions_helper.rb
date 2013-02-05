module QuestionsHelper
  def question_image_tag(question)
    if question.picture.present?
      content_tag :div, :class => "picture-container" do
        link_to question.picture.url, :class => "fancybox" do
          image_tag question.picture.url(:resized), :class => "thumbnail", :alt => question.title
        end
      end
    end
  end
end
