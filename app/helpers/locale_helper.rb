module LocaleHelper
  def locale_error! key, code
    error! I18n.t(key), code
  end
end
