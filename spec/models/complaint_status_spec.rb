require 'spec_helper'

describe ComplaintStatus do
 it { should have_many(:complaints) }
end
