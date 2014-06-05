require 'spec_helper'

describe 'lynis', :type => :class do

  it { should create_class('lynis') }
  it { should contain_class('lynis::install') }

end

