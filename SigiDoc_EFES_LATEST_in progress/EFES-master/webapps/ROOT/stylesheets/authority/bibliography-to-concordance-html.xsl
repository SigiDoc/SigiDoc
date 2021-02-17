<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
    <xsl:variable name="bibl-id" select="substring-after(str[@name='concordance_bibliography_ref'], '#')" />
    <li>
      <a href="{kiln:url-for-match('local-concordance-bibliography-item', ($language, $bibl-id), 0)}"><!-- creates the link from the concordance ref to the item and cited range -->
        <xsl:apply-templates mode="full-citation" select="id($bibl-id)" />
      </a>
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

  <xsl:template match="tei:author"><!-- STILL NECESSARY????????????????? -->
    <xsl:value-of select="." />
    <xsl:if test="following-sibling::tei:author">
      <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- replaced with lines 64-165 by SigiDoc -->
  <!--<xsl:template match="tei:bibl" mode="full-citation">
    <xsl:apply-templates select="tei:author" />
    <xsl:apply-templates select="tei:editor" />
    <xsl:apply-templates select="tei:date" />
    <xsl:apply-templates select="tei:title" />
  </xsl:template>-->
  
  <xsl:template match="tei:biblStruct//tei:author//tei:surname" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:author//tei:name" mode="full-citation"><!-- esp. for ancient authors known by a single name -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:editor//tei:surname" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text> (ed.), </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:forename" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='m']" mode="full-citation">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='j']" mode="full-citation">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='s']" mode="full-citation"><!-- without italic -->
    (<xsl:apply-templates />)
    <xsl:text></xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='u']" mode="full-citation">
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:title[@level='a']" mode="full-citation"><!-- for articles in journals or book sections -->
    <i>
      <xsl:apply-templates />
    </i>
    <xsl:text>, in</xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='volume']" mode="full-citation"><!-- for bibliography.xml; but if it indicates a subtitle with volume number, the subtitle too won't be in italic!!! -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='issue']" mode="full-citation"><!-- for bibliography.xml;  -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope[@unit='chapter']" mode="full-citation"><!-- for bibliography.xml;  -->
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:biblScope/@unit" mode="full-citation"><!-- for xml files -->
    <xsl:apply-templates />
    <xsl:text></xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:pubPlace" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:publisher" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='book']//tei:date" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text/>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='bookSection']//tei:date" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct[@type='journalArticle']//tei:date" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text>, </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:biblStruct//tei:citedRange" mode="full-citation">
    <xsl:apply-templates />
    <xsl:text/>
  </xsl:template>
  

  <xsl:template match="tei:bibl" mode="short-citation">
    <xsl:choose>
      <xsl:when test="tei:editor">
        <xsl:value-of select="tei:editor[1]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="tei:author[1]" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select=".//tei:date[1]" />
  </xsl:template>

  <!--<xsl:template match="tei:editor">
    <xsl:value-of select="." />
    <xsl:choose>
      <xsl:when test="following-sibling::tei:editor">
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> (ed</xsl:text>
        <xsl:if test="preceding-sibling::tei:editor">
          <xsl:text>s</xsl:text>
        </xsl:if>
        <xsl:text>) </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->

</xsl:stylesheet>
