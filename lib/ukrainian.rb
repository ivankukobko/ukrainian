$KCODE = 'u' if RUBY_VERSION < "1.9"

#require File.join(File.dirname(__FILE__), 'ukrainian/backend/simple')
$:.push File.join(File.dirname(__FILE__), 'ukrainian')

require 'i18n'
require 'ukrainian_rails'

module Ukrainian
  extend self

  autoload :Transliteration, 'transliteration'

  def pluralize(n, *variants)
    raise ArgumentError, "Must have a Numeric as a first parameter" unless n.is_a?(Numeric)
    raise ArgumentError, "Must have at least 3 variants for pluralization" if variants.size < 3
    raise ArgumentError, "Must have at least 4 variants for pluralization" if (variants.size < 4 && n != n.round)
    I18n.backend.send(:pluralize, :uk, {:one => variants[0], :few => variants[1],
      :many => variants[2], :other => variants[3] || variants[2]}, n)
  end

  def transliterate(str)
    Ukrainian::Transliteration.transliterate(str)
  end
  alias :translit :transliterate

  # Ukrainian locale
  LOCALE = :uk

  # Ukrainian locale
  def locale
    LOCALE
  end

  # Regexp machers for context-based russian month names and day names translation
  LOCALIZE_ABBR_MONTH_NAMES_MATCH = /(%[-\d]?d|%e)(.*)(%b)/
  LOCALIZE_MONTH_NAMES_MATCH = /(%[-\d]?d|%e)(.*)(%B)/
  LOCALIZE_STANDALONE_ABBR_DAY_NAMES_MATCH = /^%a/
  LOCALIZE_STANDALONE_DAY_NAMES_MATCH = /^%A/

  # See I18n::localize
  def localize(object, options = {})
    I18n.localize(object, options.merge({ :locale => LOCALE }))
  end
  alias :l :localize

  def translate(key, options = {})
    I18n.translate(key, options.merge({ :locale => LOCALE }))
  end
  alias :t :translate

  def init_i18n
    I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
    I18n::Backend::Simple.send(:include, I18n::Backend::Transliterator)

    I18n.load_path.unshift(*locale_files)

    I18n.reload!
  end

  # strftime() proxy with Russian localization
  def strftime(object, format = :default)
    localize(object, { :format => format })
  end

  protected
  def locale_path
    File.join(File.dirname(__FILE__), 'ukrainian', 'locales', '**/*')
  end

  def locale_files
    Dir[locale_path]
  end
end

Ukrainian.init_i18n
