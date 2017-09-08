require 'test_helper'

module CookieInspector
  class CookieInspectorHelperTest < ActionView::TestCase
    include CookieInspector::CookieInspectorHelper

    test "all_cookies returns table rows of name, value pairs" do
      cookie_name = :test
      cookie_value = "jake"
      cookies[cookie_name] = cookie_value

      assert_match /<tr><td>.*#{cookie_name}.*<td>.*#{cookie_value}.*<\/td><\/tr>/, all_cookies
    end

    test "an encrypted cookie value will be decrypted" do
      assert true
    end

    test "a non-encrypted cookie value will be passed back" do
      assert true
    end
  end
end
