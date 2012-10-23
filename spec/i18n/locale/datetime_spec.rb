# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + '/../../spec_helper'

describe I18n, "Ukrainian Date/Time localization" do
  before(:all) do
    Ukrainian.init_i18n
    @date = Date.parse("1985-12-01")
    @time = Time.local(1985, 12, 01, 16, 05)
  end

  describe "with date formats" do
    it "should use default format" do
      l(@date).should == "01.12.1985"
    end

    it "should use short format" do
      l(@date, :format => :short).should == "01 груд."
    end

    it "should use long format" do
      l(@date, :format => :long).should == "01 грудня 1985"
    end
  end

  describe "with date day names" do
    it "should use day names" do
      l(@date, :format => "%d %B (%A)").should == "01 грудня (неділя)"
      l(@date, :format => "%d %B %Y року була %A").should == "01 грудня 1985 року була неділя"
    end

    it "should use standalone day names" do
      l(@date, :format => "%A").should == "Неділя"
      l(@date, :format => "%A, %d %B").should == "Неділя, 01 грудня"
    end

    it "should use abbreviated day names" do
      l(@date, :format => "%a").should == "Нд"
      l(@date, :format => "%a, %d %b %Y").should == "Нд, 01 груд. 1985"
    end
  end

  describe "with month names" do
    it "should use month names" do
      l(@date, :format => "%d %B").should == "01 грудня"
      l(@date, :format => "%-d %B").should == "1 грудня"

      if RUBY_VERSION > "1.9.2"
        l(@date, :format => "%1d %B").should == "1 грудня"
        l(@date, :format => "%2d %B").should == "01 грудня"
      end

      l(@date, :format => "%e %B %Y").should == " 1 грудня 1985"
      l(@date, :format => "<b>%d</b> %B").should == "<b>01</b> грудня"
      l(@date, :format => "<strong>%e</strong> %B %Y").should == "<strong> 1</strong> грудня 1985"
      l(@date, :format => "А було тоді %eе число %B %Y").should == "А було тоді 1е число грудня 1985"
    end

    it "should use standalone month names" do
      l(@date, :format => "%B").should == "грудень"
      l(@date, :format => "%B %Y").should == "грудень 1985"
    end

    it "should use abbreviated month names" do
      @date = Date.parse("1985-03-01")
      l(@date, :format => "%d %b").should == "01 березня"
      l(@date, :format => "%e %b %Y").should == " 1 березня 1985"
      l(@date, :format => "<b>%d</b> %b").should == "<b>01</b> березня"
      l(@date, :format => "<strong>%e</strong> %b %Y").should == "<strong> 1</strong> березня 1985"
    end

    it "should use standalone abbreviated month names" do
      @date = Date.parse("1985-03-01")
      l(@date, :format => "%b").should == "березень"
      l(@date, :format => "%b %Y").should == "березень 1985"
    end
  end

  it "should define default date components order: day, month, year" do
    I18n.backend.translate(Ukrainian.locale, :"date.order").should == [:day, :month, :year]
  end

  describe "with time formats" do
    it "should use default format" do
      l(@time).should =~ /^Вс, 01 груд. 1985, 16:05:00/
    end

    it "should use short format" do
      l(@time, :format => :short).should == "01 груд., 16:05"
    end

    it "should use long format" do
      l(@time, :format => :long).should == "01 грудня 1985, 16:05"
    end

    it "should define am and pm" do
      I18n.backend.translate(Ukrainian.locale, :"time.am").should_not be_nil
      I18n.backend.translate(Ukrainian.locale, :"time.pm").should_not be_nil
    end
  end

  protected
    def l(object, options = {})
      I18n.l(object, options.merge( { :locale => Ukrainian.locale }))
    end
end
