<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
  xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- XSLT to convert index metadata and index Solr results into
       HTML. This is the common functionality for both TEI and EpiDoc
       indices. It should be imported by the specific XSLT for the
       document type (eg, indices-epidoc.xsl). -->
  
  <xsl:import href="to-html.xsl" />
  
  <xsl:template match="index_metadata" mode="title">
    <xsl:value-of select="tei:div/tei:head" />
  </xsl:template>
  
  <xsl:template match="index_metadata" mode="head">
    <xsl:apply-templates select="tei:div/tei:head/node()" />
  </xsl:template>
  
  <xsl:template match="tei:div[@type='headings']/tei:list/tei:item">
    <th scope="col">
      <xsl:apply-templates/>
    </th>
  </xsl:template>
  
  <xsl:template match="tei:div[@type='headings']">
    <thead>
      <tr>
        <xsl:apply-templates select="tei:list/tei:item"/>
      </tr>
    </thead>
  </xsl:template>
  
  <xsl:template match="result/doc">
    <tr>
      <xsl:apply-templates select="str[@name='index_item_name']" />
      <xsl:apply-templates select="str[@name='index_abbreviation_expansion']"/>
      <xsl:apply-templates select="str[@name='index_numeral_value']"/>
      <xsl:apply-templates select="str[@name='index_AR']"/>
      <xsl:apply-templates select="str[@name='index_entry_type']"/>
      <xsl:apply-templates select="str[@name='index_ext_reference']"/>
      <xsl:apply-templates select="arr[@name='language_code']"/>
      <xsl:apply-templates select="arr[@name='index_instance_location']" />
    </tr>
  </xsl:template>
  
  <xsl:template match="response/result">
    <table class="index tablesorter">
      <xsl:apply-templates select="/aggregation/index_metadata/tei:div/tei:div[@type='headings']" />
      <tbody>
        <xsl:apply-templates select="doc"><xsl:sort select="translate(normalize-unicode(lower-case(.),'NFD'), '&#x0300;&#x0301;&#x0308;&#x0303;&#x0304;&#x0313;&#x0314;&#x0345;&#x0342;' ,'')"/></xsl:apply-templates>
      </tbody>
    </table>
  </xsl:template>
  
  <xsl:template match="str[@name='index_abbreviation_expansion']">
    <td>
      <xsl:value-of select="." />
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_item_name']">
    <th scope="row">
      <!-- Look up the value in the RDF names, in case it's there. -->
      <xsl:variable name="rdf-name" select="/aggregation/index_names/rdf:RDF/rdf:Description[@rdf:about=current()][1]/*[@xml:lang=$language][1]" />
      <xsl:choose>
        <xsl:when test="normalize-space($rdf-name)">
          <xsl:value-of select="$rdf-name" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </th>
  </xsl:template>
  
  <xsl:template match="str[@name='index_entry_type']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template> 
  
  <xsl:template match="str[@name='index_ext_reference']"> <!--added by SigiDoc (Jan Bigalke) for external references in placeName and persName--> 
    <td>
      <xsl:variable name="bibls">
        <xsl:choose>
          <xsl:when test="contains(./text(),'|')">
            <xsl:for-each select="tokenize(.,'\|')">
              <val><xsl:value-of select="."/></val>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <val><xsl:value-of select="."/></val>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:for-each select="$bibls/val">
        <xsl:variable name="tokens">
          <text><xsl:value-of select="tokenize(.,'_')[1]"/></text>
          <link><xsl:value-of select="tokenize(.,'_')[2]"/></link>
        </xsl:variable><p>
          <a target="_blank">
            <xsl:attribute name="href">
              <xsl:value-of select="$tokens/link/text()"/>
            </xsl:attribute>
            <xsl:value-of select="$tokens/text/text()"/>
          </a>
        </p>
      </xsl:for-each>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_instance_location']">
    <td>
      <ul class="index-instances inline-list">
        <xsl:apply-templates select="str" />
      </ul>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_numeral_value']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="str[@name='index_AR']">
    <td>
      <xsl:value-of select="."/>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='language_code']">
    <td>
      <ul class="inline-list">
        <xsl:apply-templates select="str"/>
      </ul>
    </td>
  </xsl:template>
  
  <xsl:template match="arr[@name='language_code']/str">
    <li>
      <xsl:value-of select="."/>
    </li>
  </xsl:template>
  
  <xsl:template match="arr[@name='index_instance_location']/str">
    <!-- This template must be defined in the calling XSLT (eg,
         indices-epidoc.xsl) since the format of the location data is
         not universal. -->
    <xsl:call-template name="render-instance-location" />
  </xsl:template>
  
</xsl:stylesheet>
