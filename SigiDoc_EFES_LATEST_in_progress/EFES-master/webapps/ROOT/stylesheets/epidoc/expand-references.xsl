<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- Expand @sameAs references. Replace the element carrying the reference element with the content of the referenced element. The
  map:match calling this must be followed by an xinclude transformation to effect the actual inclusion. -->
  
  <xsl:include href="cocoon://_internal/url/reverse.xsl"/>
  <xsl:variable name="prefix_defs" select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:listPrefixDef" />
  <!-- Create regexp for checking whether a URL starts with a prefix. -->
  <xsl:variable name="prefixes">
    <xsl:text>^(</xsl:text>
    <xsl:for-each select="$prefix_defs/tei:prefixDef/@ident">
      <xsl:value-of select="." />
      <xsl:if test="not(position() = last())">
        <xsl:text>|</xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>):</xsl:text>
  </xsl:variable>
  
  <xsl:template match="tei:*[@sameAs]">
    <xsl:variable name="expanded-url">
      <!-- We do not currently have any @sameAs values that do not use a prefix. 
      We use a choose here just to indicate that this may change in future and 
      will require additional logic paths. -->
      <xsl:choose>
        <xsl:when test="matches(@sameAs, $prefixes)">
          <xsl:variable name="prefix" select="substring-before(@sameAs, ':')"/>       
          <xsl:variable name="prefixDef" select="$prefix_defs/tei:prefixDef[@ident=$prefix]"/>
          <xsl:variable name="relative-url" select="replace(substring-after(@sameAs, ':'), $prefixDef/@matchPattern, $prefixDef/@replacementPattern)"/>
          <xsl:value-of select="substring-after(resolve-uri($relative-url, 'file://epidoc/'), 'file://')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="make-xinclude">
      <xsl:with-param name="url" select="$expanded-url"/>
    </xsl:call-template>
  </xsl:template>
 
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
   
  <xsl:template name="make-xinclude">
    <xsl:param name="url"/>
    <xsl:variable name="final-url" select="replace($url, '#', '?id=')"/>
    <xi:include href="{kiln:url-for-match('extract-referenced-content', ($final-url), 1)}"/>
  </xsl:template>
  
  
  
</xsl:stylesheet>