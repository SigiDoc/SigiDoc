<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="http://apache.org/cocoon/i18n/2.1">
  
  <!-- Convert a bibliography authority TEI document to a concordance
       index. -->
  
  <xsl:template match="arr[@name='concordance_bibliography_item']">
    <td>
      <ul class="inline-list">
        <xsl:apply-templates select="str" />
      </ul>
    </td>
  </xsl:template>
  
  <xsl:template match="doc" mode="item-display">
    <tr>
      <xsl:apply-templates select="str[@name='concordance_bibliography_cited_range']" />
      <xsl:apply-templates select="arr[@name='concordance_bibliography_item']" />
    </tr>
  </xsl:template>
  
  <xsl:template match="doc" mode="bibl-list">  
    <xsl:variable name="bibl-id" select="str[@name='concordance_bibliography_ref']" />
    <li>
      <a href="{kiln:url-for-match('local-concordance-bibliography-item', ($language, $bibl-id), 0)}">
        <xsl:apply-templates mode="short-citation" select="id($bibl-id)" />
      </a>: <xsl:apply-templates mode="full-citation" select="id($bibl-id)" />
    </li>
  </xsl:template>
  
  <xsl:template match="str[@name='concordance_bibliography_cited_range']">
    <td>
      <xsl:value-of select="." />
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='concordance_bibliography_item']/str">
    <li>
      <a href="{kiln:url-for-match('local-epidoc-display-html', ($language, .), 0)}">
        <xsl:value-of select="." />
      </a>
    </li>
  </xsl:template>
  
  <xsl:template match="tei:bibl[@xml:id]" mode="full-citation">
    <xsl:apply-templates select="node() except tei:bibl[@type]" />
    <!--<xsl:apply-templates select="tei:author" />
    <xsl:apply-templates select="tei:editor" />
    <xsl:apply-templates select="tei:date[1]" />
    <xsl:apply-templates select="tei:title[1]" />
    <xsl:apply-templates select="tei:title[2]" />-->
  </xsl:template>
  
  <xsl:template match="tei:bibl[@xml:id]" mode="short-citation">
    <strong><xsl:value-of select="tei:bibl[@type='abbrev']"/></strong>
    <!--<xsl:choose>
      <xsl:when test="tei:editor">
        <xsl:value-of select="tei:editor[1]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="tei:author[1]" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select=".//tei:date[1]" />-->
  </xsl:template>
  
  <xsl:template match="tei:bibl[@type='abbrev']">
    <xsl:value-of select="." />
  </xsl:template>
  
  <xsl:template match="tei:author">
    <xsl:value-of select="." />
    <xsl:choose>
      <xsl:when test="following-sibling::tei:author">
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>, </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:title[@level='m']">
    <i><xsl:value-of select="." /></i>
    <xsl:choose>
      <xsl:when test="following-sibling::tei:biblScope[@unit='part']">
        <xsl:text>: </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>, </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:biblScope[@unit='part']">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblScope[@unit='volume']">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblScope[@unit='issue']">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblScope[@unit='chapter']">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:ref[@target]">
    <a target="_blank"><xsl:attribute name="href"><xsl:value-of select="@target" /></xsl:attribute><xsl:value-of select="." /></a>
  </xsl:template>
  
  <xsl:template match="tei:editor">
    <xsl:value-of select="." />
    <xsl:choose>
      <xsl:when test="following-sibling::tei:editor">
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <i18n:text i18n:key="epidoc-xslt-sigidoc-ed"><xsl:text> (ed</xsl:text>
        <xsl:if test="preceding-sibling::tei:editor">
          <xsl:text>s</xsl:text>
        </xsl:if>
        <xsl:text>.), </xsl:text></i18n:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:pubPlace">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:publisher">
    <xsl:value-of select="." />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:date">
    <xsl:value-of select="." />
    <xsl:choose>
      <xsl:when test="following-sibling::tei:biblScope [@unit='page']">
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:when test=" following-sibling::tei:series">
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>.</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:title[@level='s']">
    (<xsl:apply-templates/>).
  </xsl:template>
  
  <xsl:template match="tei:title[@level='a']">
    "<xsl:apply-templates/>",
    <xsl:choose>
      <xsl:when test="following-sibling::tei:title[@level='m']">
        <i18n:text i18n:key="epidoc-xslt-sigidoc-in"><xsl:text> in </xsl:text></i18n:text>
      </xsl:when>
      <xsl:when test="following-sibling::tei:title[@level='j']">
        <xsl:text></xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>, </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 
 <!--<xsl:template match="tei:biblScope[@unit='page']">
   <xsl:value-of select="." />
   <xsl:text>.</xsl:text>
 </xsl:template>-->
  
  <xsl:template match="tei:biblScope[@unit='page']">
    <xsl:choose>
      <xsl:when test="following-sibling::tei:series">
        <xsl:value-of select="." />
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
        <xsl:text>.</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 

  <!--<xsl:template match="tei:title[1]">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="." />
  </xsl:template>
  
  <xsl:template match="tei:title[2]">
    <xsl:choose>
      <xsl:when test="@level='j'">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="." />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>, in </xsl:text>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
</xsl:stylesheet>