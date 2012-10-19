# -*- encoding: utf-8 -*-

module Ukrainian
  # Ukrainian transliteration
  #
  # Транслитерация для букв украинского алфавита
  module Transliteration
    extend self

    # Transliteration heavily based on rutils gem by Julian "julik" Tarkhanov and Co.
    # <http://rutils.rubyforge.org/>
    # Cleaned up and optimized.

    LOWER_SINGLE = {
      "а"=>"a",  "б"=>"b",   "в"=>"v",  "г"=>"g",
      "ґ"=>"h",  "д"=>"d",   "е"=>"e",  "є"=>"ye",  
      "ж"=>"zh", "з"=>"z",   "и"=>"y",  "і"=>"i", 
      "ї"=>"yi", "й"=>"j",   "к"=>"k",  "л"=>"l",
      "м"=>"m",  "н"=>"n",   "о"=>"o",  "п"=>"p",
      "р"=>"r",  "с"=>"s",   "т"=>"t",  "у"=> "u",
      "ф"=>"f",  "х"=>"kh",  "ц"=>"ts", "ч"=>"ch",
      "ш"=>"sh", "щ"=>"sch", "ь"=>"'",  "ю"=>"yu",
      "я"=>"ya", "№"=>"#"
    }
    LOWER_MULTI = {
      "зг"=>"zgh"
    }

    UPPER_SINGLE = {
      "А"=>"A",  "Б"=>"B",   "В"=>"V",  "Г"=>"G",
      "Ґ"=>"H",  "Д"=>"D",   "Е"=>"E",  "Є"=>"YE",
      "Ж"=>"ZH", "З"=>"Z",   "И"=>"Y",  "І"=>"I",
      "Ї"=>"YI", "Й"=>"J",   "К"=>"K",  "Л"=>"L",
      "М"=>"M",  "Н"=>"N",   "О"=>"O",  "П"=>"P",
      "Р"=>"R",  "С"=>"S",   "Т"=>"T",  "У"=> "U",
      "Ф"=>"F",  "Х"=>"KH",  "Ц"=>"TS", "Ч"=>"CH",
      "Ш"=>"SH", "Щ"=>"SCH", "Ь"=>"'",  "Ю"=>"YU",
      "Я"=>"YA", "№"=>"#"
    }
    UPPER_MULTI = {
      "ЗГ"=>"ZGH"
    }

    LOWER = (LOWER_SINGLE.merge(LOWER_MULTI)).freeze
    UPPER = (UPPER_SINGLE.merge(UPPER_MULTI)).freeze
    MULTI_KEYS = (LOWER_MULTI.merge(UPPER_MULTI)).keys.sort_by {|s| s.length}.reverse.freeze

    # Transliterate a string with ukrainian characters
    #
    # Возвращает строку, в которой все буквы украинского алфавита заменены на похожую по звучанию латиницу
    def transliterate(str)
      chars = str.scan(%r{#{MULTI_KEYS.join '|'}|\w|.})

      result = ""

      chars.each_with_index do |char, index|
        if UPPER.has_key?(char) && LOWER.has_key?(chars[index+1])
          # combined case
          result << UPPER[char].downcase.capitalize
        elsif UPPER.has_key?(char)
          result << UPPER[char]
        elsif LOWER.has_key?(char)
          result << LOWER[char]
        else
          result << char
        end
      end

      result
    end
  end
end
