<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../kiln/stylesheets/solr/tei-to-solr.xsl" />

  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 18, 2010</xd:p>
      <xd:p><xd:b>Author:</xd:b> jvieira</xd:p>
      <xd:p>This stylesheet converts a TEI document into a Solr index document. It expects the parameter file-path,
      which is the path of the file being indexed.</xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:template match="/">
    <add>
      <xsl:apply-imports />
    </add>
  </xsl:template>
  <xsl:template match="tei:idno[@type='SigiDocID']" mode="facet_sigidoc_id_number">
    <field name="sigidoc_id_number">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:persName/@ref" mode="facet_personal_names">
    <field name="personal_names">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:placeName/@ref" mode="facet_place_names">
    <field name="place_names">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='dignity']/@ref" mode="facet_dignities">
    <field name="dignities">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='officeCivil']/@ref" mode="facet_civil_offices">
    <field name="civil_offices">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='officeEcclesiastical']/@ref" mode="facet_ecclesiastical_offices">
    <field name="ecclesiastical_offices">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='officeMilitary']/@ref" mode="facet_military_offices">
    <field name="military_offices">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='title']/@ref" mode="facet_titles">
    <field name="titles">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='marianTerm']/@ref" mode="facet_marian_terms">
    <field name="marian_terms">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='christTerm']/@ref" mode="facet_christ-related_terms">
    <field name="christ-related_terms">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type='saintsTerm']/@ref" mode="facet_saints-related_terms">
    <field name="saints-related_terms">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:figDesc[@n='whole']/@ref" mode="facet_iconography">
    <field name="iconography">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- This template is called by the Kiln tei-to-solr.xsl as part of
       the main doc for the indexed file. Put any code to generate
       additional Solr field data (such as new facets) here. -->
  <xsl:template name="extra_fields" >
    <xsl:call-template name="field_sigidoc_id_number"/>
    <xsl:call-template name="field_personal_names"/>
    <xsl:call-template name="field_place_names"/>
    <xsl:call-template name="field_dignities"/>
    <xsl:call-template name="field_civil_offices"/>
    <xsl:call-template name="field_ecclesiastical_offices"/>
    <xsl:call-template name="field_military_offices"/>
    <xsl:call-template name="field_titles"/>
    <xsl:call-template name="field_marian_terms"/>
    <xsl:call-template name="field_christ-related_terms"/>
    <xsl:call-template name="field_saints-related_terms"/>
    <xsl:call-template name="field_iconography"/>
    
  </xsl:template>
  <xsl:template name="field_sigidoc_id_number">
    <xsl:apply-templates mode="facet_sigidoc_id_number" select="//tei:idno[@type='SigiDocID']"/>
  </xsl:template>
  <xsl:template name="field_personal_names">
    <xsl:apply-templates mode="facet_personal_names" select="//tei:persName/@ref"/>
  </xsl:template>
  <xsl:template name="field_place_names">
    <xsl:apply-templates mode="facet_place_names" select="//tei:placeName/@ref"/>
  </xsl:template>
  <xsl:template name="field_dignities">
    <xsl:apply-templates mode="facet_dignities" select="//tei:rs[@type='dignity']/@ref"/>
  </xsl:template>
  <xsl:template name="field_civil_offices">
    <xsl:apply-templates mode="facet_civil_offices" select="//tei:rs[@type='officeCivil']/@ref"/>
  </xsl:template>
  <xsl:template name="field_ecclesiastical_offices">
    <xsl:apply-templates mode="facet_ecclesiastical_offices" select="//tei:rs[@type='officeEcclesiastical']/@ref"/>
  </xsl:template>
  <xsl:template name="field_military_offices">
    <xsl:apply-templates mode="facet_military_offices" select="//tei:rs[@type='officeMilitary']/@ref"/>
  </xsl:template>
  <xsl:template name="field_titles">
    <xsl:apply-templates mode="facet_titles" select="//tei:rs[@type='title']/@ref"/>
  </xsl:template>
  <xsl:template name="field_marian_terms">
    <xsl:apply-templates mode="facet_marian_terms" select="//tei:rs[@type='marianTerm']/@ref"/>
  </xsl:template>
  <xsl:template name="field_christ-related_terms">
    <xsl:apply-templates mode="facet_christ-related_terms" select="//tei:rs[@type='christTerm']/@ref"/>
  </xsl:template>
  <xsl:template name="field_saints-related_terms">
    <xsl:apply-templates mode="facet_saints-related_terms" select="//tei:rs[@type='saintsTerm']/@ref"/>
  </xsl:template>
  <xsl:template name="field_iconography">
    <xsl:apply-templates mode="facet_iconography" select="//tei:figDesc[@n='whole']/@ref"/>
  </xsl:template>

</xsl:stylesheet>
