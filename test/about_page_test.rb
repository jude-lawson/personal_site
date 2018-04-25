require './test/test_helper'

class AboutPageTest < CapybaraTestCase
  def test_user_sees_homepage
    visit '/about'

    assert_equal 200, page.status_code
    assert page.has_content?("About Me!")
  end
end
