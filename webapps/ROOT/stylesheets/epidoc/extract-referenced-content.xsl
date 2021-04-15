<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Extract the content referenced by the id parameter, or the
       entire document if no id is supplied. -->

  <xsl:param name="id" />

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$id">
         <xsl:copy-of select="id($id)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
