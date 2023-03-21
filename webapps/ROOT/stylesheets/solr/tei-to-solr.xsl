<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
  xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../kiln/stylesheets/solr/tei-to-solr.xsl"/>

  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 18, 2010</xd:p>
      <xd:p><xd:b>Author:</xd:b> jvieira</xd:p>
      <xd:p>This stylesheet converts a TEI document into a Solr index document. It expects the
        parameter file-path, which is the path of the file being indexed.</xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:template match="/">
    <add>
      <xsl:apply-imports/>
    </add>
  </xsl:template>
  <xsl:template match="tei:idno[@type = 'SigiDocID']" mode="facet_sigidoc_id_number">
    <field name="sigidoc_id_number">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_persons">
    <field name="persons">
      <xsl:variable name="prosopography"
        select="doc('../../content/xml/authority/prosopography.xml')"/>
      <xsl:variable name="pers-id" select="substring-after(@ref, '#')"/>
      <xsl:variable name="forename"
        select="$prosopography//tei:person[@xml:id = $pers-id]//tei:forename/tei:reg[@xml:lang = 'grc' or @xml:lang = 'la']"/>
      <xsl:variable name="surname"
        select="$prosopography//tei:person[@xml:id = $pers-id]//tei:surname/tei:reg[@xml:lang = 'grc' or @xml:lang = 'la']"/>
      <xsl:choose>
        <xsl:when test="$forename and $surname">
          <xsl:value-of
            select="concat($prosopography//tei:person[@xml:id = $pers-id]//$surname, ', ', $forename)"
          />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of
            select="$prosopography//tei:person[@xml:id = $pers-id]//tei:reg[@xml:lang = 'grc' or @xml:lang = 'la']"
          />
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template match="tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_personal_names">
    <field name="personal_names">
      <xsl:variable name="prosopography"
        select="doc('../../content/xml/authority/prosopography.xml')"/>
      <xsl:variable name="pers-id" select="substring-after(@ref, '#')"/>
      <xsl:variable name="forename"
        select="$prosopography//tei:person[@xml:id = $pers-id]//tei:forename//tei:reg[@xml:lang = 'grc' or @xml:lang = 'la']"/>
      <xsl:value-of select="$forename[@xml:lang = 'grc' or @xml:lang = 'la']"/>
    </field>
  </xsl:template>
  <xsl:template match="tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_family_names">
    <field name="family_names">
      <xsl:variable name="prosopography"
        select="doc('../../content/xml/authority/prosopography.xml')"/>
      <xsl:variable name="pers-id" select="substring-after(@ref, '#')"/>
      <xsl:variable name="surname"
        select="$prosopography//tei:person[@xml:id = $pers-id]//tei:surname//tei:reg[@xml:lang = 'grc' or @xml:lang = 'la']"/>
      <xsl:value-of select="$surname"/>
    </field>
  </xsl:template>
  <xsl:template match="tei:placeName[@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_place_names">
    <field name="place_names">
      <xsl:variable name="geography" select="doc('../../content/xml/authority/geography.xml')"/>
      <xsl:variable name="geo-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$geography//tei:place[@xml:id = $geo-id]//tei:placeName[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type = 'dignity'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_dignities">
    <field name="dignities">
      <xsl:variable name="dignities" select="doc('../../content/xml/authority/dignities.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$dignities//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'office'][@subtype = 'civil'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_civil_offices">
    <field name="civil_offices">
      <xsl:variable name="offices" select="doc('../../content/xml/authority/offices.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$offices//tei:list[@type = 'civil']//tei:item[@xml:lang = 'grc' or @xml:lang = 'la']//tei:term[@xml:id = $ref-id]"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'office'][@subtype = 'ecclesiastical'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_ecclesiastical_offices">
    <field name="ecclesiastical_offices">
      <xsl:variable name="offices" select="doc('../../content/xml/authority/offices.xml')"/>
      <xsl:variable name="offices" select="doc('../../content/xml/authority/offices.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$offices//tei:list[@type = 'ecclesiastical']//tei:item[@xml:lang = 'grc' or @xml:lang = 'la']//tei:term[@xml:id = $ref-id]"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'office'][@subtype = 'military'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_military_offices">
    <field name="military_offices">
      <xsl:variable name="offices" select="doc('../../content/xml/authority/offices.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$offices//tei:list[@type = 'military']//tei:item[@xml:lang = 'grc' or @xml:lang = 'la']//tei:term[@xml:id = $ref-id]"
      />
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type = 'title'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_titles">
    <field name="titles">
      <xsl:variable name="titles" select="doc('../../content/xml/authority/titles.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$titles//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'marianTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_marian_terms">
    <field name="marian_terms">
      <xsl:variable name="appellatives" select="doc('../../content/xml/authority/appellatives.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$appellatives//tei:list[@type = 'marianTerms']//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'christTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_christ-related_terms">
    <field name="christ-related_terms">
      <xsl:variable name="appellatives" select="doc('../../content/xml/authority/appellatives.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$appellatives//tei:list[@type = 'christTerms']//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template
    match="tei:rs[@type = 'saintsTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_saints-related_terms">
    <field name="saints-related_terms">
      <xsl:variable name="appellatives" select="doc('../../content/xml/authority/appellatives.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of
        select="$appellatives//tei:list[@type = 'saintsTerms']//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'grc' or @xml:lang = 'la']"
      />
    </field>
  </xsl:template>
  <xsl:template match="tei:figDesc[@n = 'whole'][@xml:lang = 'en']" mode="facet_iconography">
    <field name="iconography">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:rs[@type = 'legendsCases'][@ref][ancestor::tei:div/@type = 'textpart']"
    mode="facet_legend_case">
    <field name="legend_case">
      <xsl:variable name="cases" select="doc('../../content/xml/authority/legendsCases.xml')"/>
      <xsl:variable name="ref-id" select="substring-after(@ref, '#')"/>
      <xsl:value-of select="$cases//tei:item[@xml:id = $ref-id]//tei:term[@xml:lang = 'en']"/>
      <!--here as well as in iconography we could find a way to change the language according to the main language of the page-->
    </field>
  </xsl:template>
  <xsl:template match="tei:collection[@xml:lang = 'en']" mode="facet_collection">
    <field name="collection">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  <xsl:template match="tei:msIdentifier/tei:repository[@xml:lang = 'en']" mode="facet_repository">
    <field name="repository">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>

  <!-- This template is called by the Kiln tei-to-solr.xsl as part of
       the main doc for the indexed file. Put any code to generate
       additional Solr field data (such as new facets) here. -->
  <xsl:template name="extra_fields">
    <xsl:call-template name="field_sigidoc_id_number"/>
    <xsl:call-template name="field_persons"/>
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
    <xsl:call-template name="field_legend_case"/>
    <xsl:call-template name="field_collection"/>
    <xsl:call-template name="field_repository"/>
    <xsl:call-template name="field_personal_names"/>
    <xsl:call-template name="field_family_names"/>

  </xsl:template>
  <xsl:template name="field_sigidoc_id_number">
    <xsl:apply-templates mode="facet_sigidoc_id_number" select="//tei:idno[@type = 'SigiDocID']"/>
  </xsl:template>
  <xsl:template name="field_persons">
    <xsl:apply-templates mode="facet_persons"
      select="//tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_personal_names">
    <xsl:apply-templates mode="facet_personal_names"
      select="//tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_family_names">
    <xsl:apply-templates mode="facet_family_names"
      select="//tei:persName[@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_place_names">
    <xsl:apply-templates mode="facet_place_names"
      select="//tei:placeName[@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_dignities">
    <xsl:apply-templates mode="facet_dignities"
      select="//tei:rs[@type = 'dignity'][@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_civil_offices">
    <xsl:apply-templates mode="facet_civil_offices"
      select="//tei:rs[@type = 'office'][@subtype = 'civil'][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_ecclesiastical_offices">
    <xsl:apply-templates mode="facet_ecclesiastical_offices"
      select="//tei:rs[@type = 'office'][@subtype = 'ecclesiastical'][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_military_offices">
    <xsl:apply-templates mode="facet_military_offices"
      select="//tei:rs[@type = 'office'][@subtype = 'military'][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_titles">
    <xsl:apply-templates mode="facet_titles"
      select="//tei:rs[@type = 'title'][@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_marian_terms">
    <xsl:apply-templates mode="facet_marian_terms"
      select="//tei:rs[@type = 'marianTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_christ-related_terms">
    <xsl:apply-templates mode="facet_christ-related_terms"
      select="//tei:rs[@type = 'christTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_saints-related_terms">
    <xsl:apply-templates mode="facet_saints-related_terms"
      select="//tei:rs[@type = 'saintsTerms'][@subtype][@ref][ancestor::tei:div/@type = 'textpart']"
    />
  </xsl:template>
  <xsl:template name="field_iconography">
    <xsl:apply-templates mode="facet_iconography"
      select="//tei:figDesc[@n = 'whole'][@xml:lang = 'en']"/>
  </xsl:template>
  <xsl:template name="field_legend_case">
    <xsl:apply-templates mode="facet_legend_case"
      select="//tei:rs[@type = 'legendsCases'][@ref][ancestor::tei:div/@type = 'textpart']"/>
  </xsl:template>
  <xsl:template name="field_collection">
    <xsl:apply-templates mode="facet_collection" select="//tei:collection[@xml:lang = 'en']"/>
  </xsl:template>
  <xsl:template name="field_repository">
    <xsl:apply-templates mode="facet_repository"
      select="//tei:msIdentifier/tei:repository[@xml:lang = 'en']"/>
  </xsl:template>

</xsl:stylesheet>
