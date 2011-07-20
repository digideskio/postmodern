#!/usr/bin/env ronin-dork -f

require 'ronin/dorks/google_dork'

Ronin::Dorks::GoogleDork.object do

  cache do
    self.name = 'MS SOAP Defaults'
    self.description = %{
      Finds default MS SOAP API installations.
    }

    author :name => 'Postmodern', :organization => 'SophSec'
    license! :mit
  end

  dork do
    query(:intext => '"This web service is using http://tempuri.org/ as its default namespace." "Recommendation: Change the default namespace before the XML Web service is made public."')
  end

end
