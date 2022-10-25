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

  <xsl:template match="/">
    <add>
      <xsl:for-each-group select="//tei:persName[@ref][ancestor::tei:div/@type='textpart']" group-by="@ref">
        <xsl:variable name="ref-id" select="normalize-unicode(substring-after(@ref, '#'))"/>
        <xsl:variable name="ref" select="document('../../content/xml/authority/prosopography.xml')//tei:person[@xml:id=$ref-id]"/>
        <xsl:variable name="nymRef" select="document('../../content/xml/authority/prosopography.xml')//tei:person//tei:persName[.=$ref-id]"/>
        <doc>
          <field name="document_type">
            <xsl:value-of select="$subdirectory" />
            <xsl:text>_</xsl:text>
            <xsl:value-of select="$index_type" />
            <xsl:text>_index</xsl:text>
          </field>
          <xsl:call-template name="field_file_path" />
          <field name="index_item_name">
            <field name="index_item_name">
              <xsl:choose>
                <xsl:when test="$ref">
                  <xsl:choose>
                    <xsl:when test="$ref//tei:persName[@xml:lang='grc']"><xsl:value-of select="$ref//tei:persName[@xml:lang='grc'][1]" /></xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test="$ref//tei:persName[@xml:lang='la']"><xsl:value-of select="$ref//tei:persName[@xml:lang='la'][1]" /></xsl:when>
                        <xsl:otherwise><xsl:value-of select="$ref//tei:persName[1]" /></xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$ref-id" />
                </xsl:otherwise>
              </xsl:choose>
            </field>
           <!-- <xsl:value-of select="$ref-id" />-->
            <field name="index_item_sort_name">
              <xsl:choose>
                <xsl:when test="$nymRef">
                  <xsl:value-of select="$nymRef[1]" />
                </xsl:when>
                <xsl:otherwise/>
              </xsl:choose>
            </field>
            <field name="index_external_resource">
              <xsl:value-of select="$ref/tei:link" />
            </field>
          </field>
          <xsl:apply-templates select="current-group()" >
            <xsl:sort/>
          </xsl:apply-templates>
        </doc>
      </xsl:for-each-group>
    </add>
  </xsl:template>

  <xsl:template match="tei:persName">
    <xsl:call-template name="field_index_instance_location" />
  </xsl:template>

</xsl:stylesheet>
