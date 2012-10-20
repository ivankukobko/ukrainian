#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe Ukrainian::Transliteration do

  context "#transliterate" do

    it "should return transliterate for ukrainian characters" do
      transliterate( "Не мала баба клопоту, купила порося.").should
          eq("Ne mala baba klopotu, kupyla porosya.") 
    end

    it "should return transliterate for ukrainian characters" do
      translit( "Не мала баба клопоту, купила порося.").should
                eq("Ne mala baba klopotu, kupyla porosya.")
    end

    it "should properly transliterate mixed ukrainian-english strings" do
      translit("Ласкаво просимо до Wiki").should eq("Laskavo prosymo do Wiki")
    end

    context "should properly transliterate mixed case chars in a string" do

      it { translit("ДУЖЕ ДЯКУЮ").should == "DUZHE DYAKUYU"            }
      it { translit("До зустрічі").should == "Do zustrichi"            }
      it { translit("В. І. Вернадський").should == "V. I. Vernads'kyj"}
      it { translit("ВХІД").should == "VKHID"                           }
    end

    context "should work for multi-char substrings" do

      it { translit("21 очко").should == "21 ochko"           }
      it { translit("Вася Пупкін").should == "Vasya Pupkin" }
      it { translit("Вася").should == "Vasya"              }
      it { translit("ВАСЯ").should == "VASYA"              }
    end
  end
end
