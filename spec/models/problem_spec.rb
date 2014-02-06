require 'spec_helper'

describe Problem do
  it { should have_many(:complaints) }
end
