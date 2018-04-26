require './test/test_helper.rb'

class BlogPageTest < CapybaraTestCase
  def test_user_can_see_main_blog_page
    visit '/blog'

    assert page.has_content?("Blog!")
    assert_equal 200, page.status_code
  end
end