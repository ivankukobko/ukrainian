#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe Ukrainian::Transliteration do

  context "#transliterate" do

    it "should return transliterate for ukrainian characters" do
      transliterate( "Ще не вмерла України ні слава, ні воля, Ще нам, браття молодії, усміхнеться доля.").should
          eq("Shhe ne vmerla Ukrayiny ni slava, ni volya, Shhe nam, brattya molodiyi, usmixnet\"sya dolya.") 
    end

    it "should return transliterate for ukrainian characters" do
      translit( "Ще не вмерла України ні слава, ні воля, Ще нам, браття молодії, усміхнеться доля.").should
          eq("Shhe ne vmerla Ukrayiny ni slava, ni volya, Shhe nam, brattya molodiyi, usmixnet\"sya dolya.")
    end
  end
end
