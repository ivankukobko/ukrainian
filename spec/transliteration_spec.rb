# -*- encoding: utf-8 -*- 
require 'spec_helper'

describe Ukrainian do

  describe "#transliterate" do

    def t(str)
      Ukrainian::transliterate(str)
    end

    %w(transliterate translit).each do |method|
      it "'#{method}' method should perform transliteration" do
        str = mock(:str)
        Ukrainian::Transliteration.should_receive(:transliterate).with(str)
        Ukrainian.send(method, str)
      end
    end

    it "should return transliterate for ukrainian characters" do
      transliterate( "Не мала баба клопоту, купила порося.").should
      eq("Ne mala baba klopotu, kupyla porosya.")
    end

    it "should return transliterate for ukrainian characters" do
      translit( "Не мала баба клопоту, купила порося.").should
      eq("Ne mala baba klopotu, kupyla porosya.")
    end

    context "should transliterate properly" do

      it { t("Це просто якийсь текст").should == "Tse prosto yakyjs' tekst" }
      it { t("щ").should == "sch"                                           }
      it { t("ш").should == "sh"                                            }
      it { t("Ш").should == "SH"                                            }
      it { t("ц").should == "ts"                                            }
    end
    

    it "should properly transliterate mixed ukrainian-english strings" do
      t("Ласкаво просимо до Wiki").should eq("Laskavo prosymo do Wiki")
    end

    context "should properly transliterate mixed case chars in a string" do

      it { t("ДУЖЕ ДЯКУЮ").should == "DUZHE DYAKUYU"            }
      it { t("До зустрічі").should == "Do zustrichi"            }
      it { t("В. І. Вернадський").should == "V. I. Vernads'kyj" }
      it { t("ВХІД").should == "VKHID"                          }
    end

    context "should work for multi-char substrings" do

      it { t("21 очко").should == "21 ochko"         }
      it { t("Вася Пупкін").should == "Vasya Pupkin" }
      it { t("Вася").should == "Vasya"               }
      it { t("ВАСЯ").should == "VASYA"               }
    end
  end
end
