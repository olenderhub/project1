module ArticlesHelper
  def author(article)
    article.user.email.to_s.split("@")[0].titleize
  end
end
