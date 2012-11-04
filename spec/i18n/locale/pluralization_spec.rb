# -*- encoding: utf-8 -*- 

require File.dirname(__FILE__) + '/../../spec_helper'

describe I18n, "Ukrainian pluralization" do
  before(:each) do
    @hash = {}
    %w(one few many other).each do |key|
      @hash[key.to_sym] = key
    end
    @backend = I18n.backend
  end
  
  context "should pluralize correctly" do

    it { @backend.send(:pluralize, :'uk', @hash, 1).should == 'one'     }
    it { @backend.send(:pluralize, :'uk', @hash, 2).should == 'few'     }
    it { @backend.send(:pluralize, :'uk', @hash, 3).should == 'few'     }
    it { @backend.send(:pluralize, :'uk', @hash, 5).should == 'many'    }
    it { @backend.send(:pluralize, :'uk', @hash, 10).should == 'many'   }
    it { @backend.send(:pluralize, :'uk', @hash, 11).should == 'many'   }
    it { @backend.send(:pluralize, :'uk', @hash, 21).should == 'one'    }
    it { @backend.send(:pluralize, :'uk', @hash, 29).should == 'many'   }
    it { @backend.send(:pluralize, :'uk', @hash, 131).should == 'one'   }
    it { @backend.send(:pluralize, :'uk', @hash, 1.31).should == 'other'}
    it { @backend.send(:pluralize, :'uk', @hash, 2.31).should == 'other'}
    it { @backend.send(:pluralize, :'uk', @hash, 3.31).should == 'other'}
  end
end
