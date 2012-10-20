#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe Ukrainian do

  context "#pluralize" do

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

    describe "invalid parameters" do

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
