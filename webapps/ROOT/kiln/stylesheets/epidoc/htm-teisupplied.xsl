<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Called from teisupplied.xsl -->

    <xsl:template name="supplied-parallel">
        <span class="underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template name="supplied-previouseditor">
        <span class="underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template name="supplied-similar"><!-- added by SigiDoc -->
        <span class="underline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>