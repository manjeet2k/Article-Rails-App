class RandomName
  include Prawn::View

  def initialize(user)
    heading_email(user)
    content(user.articles)
  end

  def heading_email(user)
    text "#{user.name} ,your articles are listed below:"
  end


  def content(articles)
    move_down 20

    articles.each do |a|
      text "#{a.name}"
      move_down 10
    end
  end
end