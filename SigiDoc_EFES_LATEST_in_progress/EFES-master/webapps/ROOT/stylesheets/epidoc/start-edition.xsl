<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:i18n="http://apache.org/cocoon/i18n/2.1">

  <!-- Project-specific XSLT for transforming EpiDoc TEI to
       HTML. Customisations here override those in the core
       start-edition.xsl (which should not be changed). -->

  <xsl:import href="../../kiln/stylesheets/epidoc/start-edition.xsl" />
  <xsl:import href="htm-tpl-struct-sigidoc.xsl"/>



  <!-- <xsl:template match="tei:bibl">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template> -->
  
  <xsl:template match="tei:biblStruct//tei:author//tei:surname">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:author//tei:name"><!-- esp. for ancient authors known by a single name -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:author//tei:forename">
    <xsl:apply-templates />
    <xsl:text> </xsl:text>
  </xsl:template>
  
  <!--<xsl:template match="tei:biblStruct//tei:editor//tei:surname">
    <xsl:apply-templates />
    <xsl:text> (ed.), </xsl:text>
  </xsl:template>-->
  
  <xsl:template match="tei:editor">
    <xsl:apply-templates />
    <xsl:choose>
      <xsl:when test="following-sibling::tei:editor//tei:surname">
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> (</xsl:text>
        <i18n:text i18n:key="epidoc-xslt-sigidoc-ed"><xsl:text>ed</xsl:text>
        <xsl:if test="preceding-sibling::tei:editor//tei:surname">
          <xsl:text>s</xsl:text>
        </xsl:if></i18n:text>
        <xsl:text>), </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="tei:biblStruct//tei:editor//tei:forename">
    <xsl:apply-templates />
    <xsl:text> </xsl:text>
  </xsl:template>
  
  
  
  <xsl:template match="tei:biblStruct//tei:title[@level='m']">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='j']">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='s']"><!-- in the Zotero-TEI conversion the volume number in the series could automatically be nested inside a <biblStruct/>, but the latter should be removed and the number nested inside <title/>, to get a proper bibliogr. ref. -->
      (<xsl:apply-templates />)
    <xsl:text></xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='u']">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='a']"><!-- for articles in journals or book sections -->
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text><i18n:text i18n:key="epidoc-xslt-sigidoc-in"><xsl:text>in</xsl:text></i18n:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='volume']"><!-- for the number of a journal: ex. REB 56 -->
      <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='issue']"><!-- for the issues composing a number of a journal: ex. 34.1, 34.2, ... -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='part']"><!-- for a book composed of different volumes -->
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='chapter']"><!-- for bibliography.xml;  -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope/@unit"><!-- for xml files -->
    <xsl:apply-templates />
    <xsl:text></xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:pubPlace">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:publisher">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='book']//tei:date">
    <xsl:apply-templates />
    <xsl:text/>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='bookSection']//tei:date">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='journalArticle']//tei:date">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:citedRange">
    <xsl:apply-templates />
    <xsl:text/>
  </xsl:template>
  
</xsl:stylesheet>
