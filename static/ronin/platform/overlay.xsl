<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" indent="yes" />

  <xsl:template match="/ronin-overlay">
    <html>
      <head>
        <title>Ronin Overlay :: <xsl:value-of select="title/." /></title>
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
        <style type="text/css">
          html {
            height: 100%;
          }

          body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: sans-serif;
            font-size: 1.0em;
            background: url(http://ronin.rubyforge.org/images/diamond.png) repeat top left;
            over-flow: auto;
          }

          #content {
            margin: 1em 10em 1em 10em;
            padding: 1em 2em 1em 2em;
            border: 20px solid black;
            background-color: white;
          }

          #content a {
            color: black;
            font-weight: bold;
            text-decoration: none;
          }

          #content pre {
            margin: 0.5em 0 0.5em 0;
            padding: 0.5em;
            color: white;
            background-color: black;
            white-space: pre;
            over-flow: auto;
          }

          #content a:hover {
            color: #BD0000;
          }
        </style>
        <style type="text/css" media="print">
          #content {
            border: none;
          }

          #content a {
            font-weight: normal;
          }
        </style>
      </head>

      <body>
        <div id="page">
          <div id="banner">
            <img id="logo" src="http://ronin.rubyforge.org/images/logo.png" />
          </div>

          <div id="content">
            <h2><xsl:value-of select="title/." /></h2>
            <p><xsl:value-of select="description/." /></p>

            <xsl:if test="dependencies"><xsl:call-template name="dependencies_section" /></xsl:if>

            <xsl:if test="source"><xsl:call-template name="install_section" /></xsl:if>

            <xsl:if test="license"><xsl:call-template name="license_section" /></xsl:if>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="dependencies_section">
    <h2>Dependencies</h2>
    <p>Before installing this Overlay you will need to install some other things first.</p>
    <xsl:if test="dependencies/gem">
      <pre>$ <xsl:for-each select="gem"> <xsl:value-of select="." /></xsl:for-each></pre>
    </xsl:if>
  </xsl:template>

  <xsl:template name="install_section">
    <h2>Install</h2>
    <p>To install this Overlay, simply run the following command:</p>
    <pre>$ ronin install <xsl:value-of select="source/." /></pre>
  </xsl:template>

  <xsl:template name="license_section">
    <h2>License</h2>

    <p>This Overlay is licensed under the <xsl:apply-templates select="license" />.</p>
  </xsl:template>

  <xsl:template match="license">
    <a>

      <xsl:choose>
        <xsl:when test=". = 'GPL-2'">
          <xsl:attribute name="href">http://www.gnu.org/licenses/gpl-2.0.html</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'GPL-3'">
          <xsl:attribute name="href">http://www.gnu.org/licenses/gpl-3.0.html</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'BSD'">
          <xsl:attribute name="href">http://www.opensource.org/licenses/bsd-license.php</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'MIT'">
          <xsl:attribute name="href">http://www.opensource.org/licenses/mit-license.html</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-by'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/by/3.0/</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-by-nd'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/by-nd/3.0/</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-by-nc-nd'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/by-nc-nd/3.0/</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-by-nc'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/by-nc/3.0/</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-by-nc-sa'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/by-nc-sa/3.0/</xsl:attribute>
        </xsl:when>

        <xsl:when test=". = 'CC-sa'">
          <xsl:attribute name="href">http://creativecommons.org/licenses/sa/3.0/</xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <xsl:value-of select="." />
    </a>
  </xsl:template>

  <xsl:template match="/ronin-overlay/source">
    <tr id="overlay-source">
      <td valign="top">
        <p><strong>Source:</strong></p>
      </td>
      <td valign="top">
        <p>
          <a>
            <xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute>
            <xsl:value-of select="." />
          </a>
        </p>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/ronin-overlay/source-view">
    <tr id="overlay-source-view">
      <td valign="top">
        <p><strong>View Source:</strong></p>
      </td>
      <td valign="top">
        <p>
          <a>
            <xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute>
            <xsl:value-of select="." />
          </a>
        </p>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/ronin-overlay/website">
    <tr id="overlay-website">
      <td valign="top">
        <p><strong>Website:</strong></p>
      </td>
      <td valign="top">
        <p>
          <a>
            <xsl:attribute name="href"><xsl:value-of select="." /></xsl:attribute>
            <xsl:value-of select="." />
          </a>
        </p>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/ronin-overlay/maintainers">
    <tr id="overlay-maintainers">
      <td valign="top">
        <p><strong>Maintainers:</strong></p>
      </td>
      <td valign="top">
        <xsl:apply-templates />
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="/ronin-overlay/maintainers/maintainer">
    <p class="maintainer">
      <xsl:choose>
        <xsl:when test="email">
          <a>
            <xsl:attribute name="href">mailto:<xsl:value-of select="email/." /></xsl:attribute>
            <xsl:value-of select="name/." />
          </a>
        </xsl:when>

        <xsl:otherwise>
          <strong><xsl:value-of select="name/." /></strong>
        </xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

  <xsl:template match="/ronin-overlay/description">
    <tr id="overlay-description">
      <td valign="top">
        <p><strong>Description:</strong></p>
      </td>
      <td valign="top">
        <p><xsl:value-of select="." /></p>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
