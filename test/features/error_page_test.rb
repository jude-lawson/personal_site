require './test/test_helper.rb'

class ErrorPageTest < CapybaraTestCase
  def test_user_gets_correct_error_messaging
    visit '/notapage'

    assert_equal 404, page.status_code
    assert page.has_content?('Whoops! This is not the page you\'re looking for...')
  end
end
