# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Ukrainian do

  describe "with locale" do
    it "should define :'uk' LOCALE" do
      Ukrainian::LOCALE.should == :'uk'
    end

    it "should provide 'locale' proxy" do
      Ukrainian.locale.should == Ukrainian::LOCALE
    end
  end

  describe "during i18n initialization" do
    after(:each) do
      I18n.load_path = []
      Ukrainian.init_i18n
    end

    it "should keep existing translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'en.yml')
      Ukrainian.init_i18n
      I18n.t(:foo, :locale => :'en').should == "bar"
    end

    it "should keep existing :uk translations while switching backends" do
      I18n.load_path << File.join(File.dirname(__FILE__), 'fixtures', 'uk.yml')
      Ukrainian.init_i18n
      I18n.t(:'date.formats.default', :locale => :'uk').should == "override"
    end

    it "should NOT set default locale to Ukrainian locale" do
      locale = I18n.default_locale
      Ukrainian.init_i18n
      I18n.default_locale.should == locale
    end
  end

  describe "with localize proxy" do
    before(:each) do
      @time = mock(:time)
      @options = { :format => "%d %B %Y" }
    end

    %w(l localize).each do |method|
      it "'#{method}' should call I18n backend localize" do
        I18n.should_receive(:localize).with(@time, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @time, @options)
      end
    end
  end

  describe "with translate proxy" do
    before(:all) do
      @object = :bar
      @options = { :scope => :foo }
    end

    %w(t translate).each do |method|
      it "'#{method}' should call I18n backend translate" do
        I18n.should_receive(:translate).with(@object, @options.merge({ :locale => Ukrainian.locale }))
        Ukrainian.send(method, @object, @options)
      end
    end
  end

  describe "strftime" do
    before(:each) do
      @time = mock(:time)
    end

    it "should call localize with object and format" do
      format = "%d %B %Y"
      Ukrainian.should_receive(:localize).with(@time, { :format => format })
      Ukrainian.strftime(@time, format)
    end

    it "should call localize with object and default format when format is not specified" do
      Ukrainian.should_receive(:localize).with(@time, { :format => :default })
      Ukrainian.strftime(@time)
    end
  end

  describe "#pluralize" do

    context "should pluralize correctly" do

      let(:variants) { %w(річ речі речей речі) }

      it { pluralize( 1, *variants).should == 'річ' }
      it { pluralize( 2, *variants).should == 'речі' }
      it { pluralize( 3, *variants).should == 'речі' }
      it { pluralize( 5, *variants).should == 'речей' }
      it { pluralize( 10, *variants).should == 'речей' }
      it { pluralize( 21, *variants).should == 'річ' }
      it { pluralize( 29, *variants).should == 'речей' }
      it { pluralize( 129, *variants).should == 'речей' }
      it { pluralize( 131, *variants).should == 'річ' }
      it { pluralize( 3.14, *variants).should == 'речі' }
    end

    context "invalid parameters" do

      let(:variants) { %w(річ речі речей речі) }

      it "should have a Numeric as a first parameter" do
        lambda {  pluralize( "1", *variants) }.should raise_error(ArgumentError, "Must have a Numeric as a first parameter")
      end

      it "should have at least 3 variants for pluralization" do
        lambda { pluralize( 1, *variants[0..1] ) }.should raise_error(ArgumentError, "Must have at least 3 variants for pluralization")
      end

      it "should have at least 4 variants for pluralization" do
        lambda { pluralize( 1.8, *variants[0..2]) }.should raise_error(ArgumentError, "Must have at least 4 variants for pluralization")
      end
    end
  end
end
