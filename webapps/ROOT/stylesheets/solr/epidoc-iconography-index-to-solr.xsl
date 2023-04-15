<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- This XSLT transforms a set of EpiDoc documents into a Solr
       index document representing an index of symbols in those
       documents. -->

  <xsl:import href="epidoc-index-utils.xsl"/>

  <xsl:param name="index_type"/>
  <xsl:param name="subdirectory"/>
  <!--<xsl:variable name="icon" select="doc('../../content/xml/authority/iconography.xml')"/>-->
  
  <xsl:template match="/">
    <add>
      <xsl:for-each-group select="//tei:figDesc[@n = 'whole'][ancestor::tei:physDesc]"
        group-by="text()">
        <doc>
          <field name="document_type">
            <xsl:value-of select="$subdirectory"/>
            <xsl:text>_</xsl:text>
            <xsl:value-of select="$index_type"/>
            <xsl:text>_index</xsl:text>
          </field>
          <xsl:call-template name="field_file_path"/>
          <field name="index_item_name">
            <xsl:value-of select="text()"/>
          </field>
          <xsl:apply-templates select="current-group()"/>
        </doc>
      </xsl:for-each-group>
    </add>
  </xsl:template>

  <!--<xsl:template match="/"> deprecated - linked to Authority List
    <add>
      <xsl:for-each-group select="//tei:figDesc[@n='whole'][@ana][ancestor::tei:physDesc]" group-by="@ana">
        <doc>
          <field name="document_type">
            <xsl:value-of select="$subdirectory" />
            <xsl:text>_</xsl:text>
            <xsl:value-of select="$index_type" />
            <xsl:text>_index</xsl:text>
          </field>
          <xsl:call-template name="field_file_path" />
          <field name="index_item_name">
              <xsl:variable name="ref-id" select="substring-after(@ana, '#')"/>
              <xsl:value-of
                select="$icon//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'en']" 
              /> <!-\-here as well as in legendCases we could find a way to change the language according to the main language of the page-\->
          </field>
          <xsl:apply-templates select="current-group()" />
        </doc>
      </xsl:for-each-group>
    </add>
  </xsl:template>-->

  <xsl:template match="tei:figDesc">
    <xsl:call-template name="field_index_instance_location"/>
  </xsl:template>

</xsl:stylesheet>
