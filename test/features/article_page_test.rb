require './test/test_helper'

class ArticlePageTest < CapybaraTestCase
  def test_user_can_see_article_page
    visit '/blog/1'

    assert page.has_content?('Article 1')
    assert_equal 200, page.status_code
  end

  def test_user_can_see_another_article
    visit '/blog/2'

    assert page.has_content?('Article 2!')
    assert_equal 200, page.status_code
  end
end