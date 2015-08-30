module EmotionHelper
  
  def content_with_emotion content
    content.gsub(/\{(face.*?)\}/) do |s|
      s = s[1..-2]
      image_tag("emotion/#{s}.png", class: "emotion")
    end
  end

  def content_without_emotion content
    content.gsub(/\{(face.*?)\}/, "")
  end


end
