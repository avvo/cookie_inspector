module CookieInspector
  module CookieInspectorHelper

    class << self
      mattr_accessor :secret_key_base
      mattr_accessor :display_debug

      self.display_debug = false

      def safe_secret_key_base
        if self.secret_key_base.nil?
          raise "The secret_key_base has not been set in the host application config"
        else
          self.secret_key_base
        end
      end
    end

    def all_cookies
      data = []
      session_cookie_name = Rails.application.config.session_options[:key]
      cookies.each do |name, value|
        if name == session_cookie_name
          decrypted_value = session_cookie_value(value)
        else
          decrypted_value = decrypt_cookie_value(value)
        end

        data << [name, decrypted_value]
      end

      format_array_for_html(data)
    end

    def format_array_for_html(data)
      data.map{|name, value|
        "<tr><td><div class='cookie-name'>#{name}</div></td><td><div class='cookie-value'>#{value}</div></td></tr>"
      }.join.html_safe
    end

    def display?
      debug = params.fetch(:cookie_inspector, nil)

      if debug.present?
        CookieInspectorHelper.display_debug = debug
      end

      if CookieInspectorHelper.display_debug == "true"
        true
      else
        false
      end

    end

  private

    def decrypt_cookie_value(value)
      Marshal.load(::Base64.decode64(value.split('--').first))
    rescue ArgumentError, TypeError
      value
    end

    def cookie_contents(cookie_name)
      "#{cookie_name}: #{decrypt_cookie_value(cookies[cookie_name])}" if cookies[cookie_name]
    end

    def session_cookie_value(value)
      key = CookieInspectorHelper.safe_secret_key_base
      decrypt_session_cookie(value, key)
    end

    # code modified from here: https://gist.github.com/pdfrod/9c3b6b6f9aa1dc4726a5
    def decrypt_session_cookie(cookie, key)
      cookie = CGI::unescape(cookie)

      # Default values for Rails 4 apps
      key_iter_num = 1000
      salt         = "encrypted cookie"
      signed_salt  = "signed encrypted cookie"

      key_generator = ActiveSupport::KeyGenerator.new(key, iterations: key_iter_num)
      secret = key_generator.generate_key(salt)
      sign_secret = key_generator.generate_key(signed_salt)

      encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: ActiveSupport::MessageEncryptor::NullSerializer)
      encryptor.decrypt_and_verify(cookie)
    end
  end
end
