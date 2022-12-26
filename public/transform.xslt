<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2 style="padding: 20px">Result</h2>
        <table class="table table-dark">
          <tr>
            <th>Segment #</th>
            <th>Segments</th>
          </tr>
          <xsl:for-each select="objects/object">
            <tr>
              <td><xsl:value-of select="index"/></td>
              <td><xsl:value-of select="value"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>