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
  
</xsl:stylesheet>
