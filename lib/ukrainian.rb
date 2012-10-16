$KCODE = 'u' if RUBY_VERSION < "1.9"

#require File.join(File.dirname(__FILE__), 'ukrainian/backend/simple')
require 'i18n'

module Ukrainian
  extend self

  def pluralize(n, *variants)
    raise ArgumentError, "Must have a Numeric as a first parameter" unless n.is_a?(Numeric)
    I18n.backend.send(:pluralize, :uk, {:one => variants[0], :few => variants[1],
      :many => variants[2], :other => variants[3] || variants[2]}, n)
  end

  def init_i18n
    I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
    I18n::Backend::Simple.send(:include, I18n::Backend::Transliterator)

    I18n.load_path.unshift(*locale_files)

    I18n.reload!
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
