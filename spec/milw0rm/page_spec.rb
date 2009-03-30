require 'milw0rm/page'

describe Milw0rm::Page do
  before(:all) do
  end

  it "should not specify the start param for 0 indices" do
    @page = Milw0rm::Page.new('http://milw0rm.com/remote.php',0)
    @page.url.query_params['start'].should be_nil
  end
end
