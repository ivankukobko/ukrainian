# -*- encoding: utf-8 -*-

# I18n transliteration delegates to Ukrainian::Transliteration (we're unable
# to use common I18n transliteration tables with Ukrainian)
#
{
  :uk => {
    :i18n => {
      :transliterate => {
        :rule => lambda { |str| Ukrainian.transliterate(str) }
      }
    }
  }
}
