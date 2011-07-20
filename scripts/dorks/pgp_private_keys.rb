#!/usr/bin/env ronin-dork -f

require 'ronin/dorks/google_dork'

Ronin::Dorks::GoogleDork.object do

  cache do
    self.name = 'PGP Private Keys'
    self.description = %{
      Finds leaked PGP Private Keys.
    }

    author :name => 'Postmodern', :organization => 'SophSec'
    license! :mit
  end

  dork do
    query(:intext => 'BEGIN PGP PRIVATE KEY BLOCK', :filetype => 'asc')
  end

end
