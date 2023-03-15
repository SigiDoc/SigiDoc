<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
                version="2.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- This XSLT transforms a set of EpiDoc documents into a Solr
       index document representing an index of symbols in those
       documents. -->

  <xsl:import href="epidoc-index-utils.xsl" />

  <xsl:param name="index_type" />
  <xsl:param name="subdirectory" />
  <xsl:variable name="geography" select="doc('../../content/xml/authority/geography.xml')"/>

  <xsl:template match="/">
    <add>
      <xsl:for-each-group select="//tei:placeName[@ref][ancestor::tei:div/@type='textpart']" group-by="@ref">
        <doc>
          <field name="document_type">
            <xsl:value-of select="$subdirectory" />
            <xsl:text>_</xsl:text>
            <xsl:value-of select="$index_type" />
            <xsl:text>_index</xsl:text>
          </field>
          <xsl:call-template name="field_file_path" />
          <field name="index_item_name">
            <xsl:variable name="geo-id" select="substring-after(@ref,'#')"/>
            <xsl:value-of select="$geography//tei:place[@xml:id = $geo-id]//tei:placeName[@xml:lang = 'grc' or @xml:lang = 'la']" />
          </field>
          <field name="index_ext_reference">
            <xsl:variable name="geo-id" select="substring-after(@ref,'#')"/>
            <xsl:variable name="geo-string">
              <xsl:for-each select="$geography//tei:place[@xml:id = $geo-id][tei:link]">
                <val><xsl:value-of select="concat(./tei:idno,'_',./tei:link/@target)"/></val>
              </xsl:for-each>
            </xsl:variable> 
            <xsl:value-of select="string-join($geo-string/val,'|')"/>
          </field>
          <xsl:apply-templates select="current-group()" />
        </doc>
      </xsl:for-each-group>
    </add>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <xsl:call-template name="field_index_instance_location" />
  </xsl:template>

</xsl:stylesheet>
