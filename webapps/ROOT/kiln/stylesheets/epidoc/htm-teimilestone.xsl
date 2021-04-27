<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- More specific templates in teimilestone.xsl -->

   <xsl:template match="t:milestone">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>      
       <xsl:choose>
         <xsl:when
             test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation']">
            <xsl:if test="@rend = 'break'">
               <br/>
            </xsl:if>
            <sup>
               <strong>
                  <xsl:value-of select="@n"/>
               </strong>
            </sup>
            <xsl:text> </xsl:text>
         </xsl:when>
           <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')">
            <xsl:choose>
               <xsl:when test="@rend = 'wavy-line'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>~~~~~~~~</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'paragraphos'">
                  <xsl:if test="following-sibling::node()[not(self::text() and normalize-space(self::text())='')][1]/self::t:lb[@break='no']">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>——</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'horizontal-rule'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>————————</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <br/>
            <xsl:value-of select="@rend"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <!-- commented out by SigiDoc -->
   <!--<xsl:template match="t:cb">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:if test="$parm-leiden-style='iospe'">
         <xsl:element name="span">
            <xsl:attribute name="class" select="'textpartnumber'"/>
            <xsl:attribute name="style" select="'left: -4em;'"/>
            <xsl:text>Col. </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:element name="br"/>
         </xsl:element>
      </xsl:if>
   </xsl:template>-->
   
   <!-- added by SigiDoc -->
   <xsl:template match="t:cb">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:if test="$parm-leiden-style='sigidoc'">
         <xsl:choose>
            <xsl:when test="@n='a'">
               <xsl:element name="span">
                  <xsl:attribute name="style" select="'vertical-align: super; position: relative; font-family: calibri; font-size: 80%'"/>
                  <xsl:text>a</xsl:text>
               </xsl:element>
            </xsl:when>
            <xsl:when test="@n='b'">
               <xsl:element name="span">
                  <xsl:text> – </xsl:text>
               </xsl:element>
               <xsl:element name="span">
                  <xsl:attribute name="style" select="'vertical-align: super; position: relative; font-family: calibri; font-size: 80%'"/>
                  <xsl:text>b  </xsl:text>
               </xsl:element>
            </xsl:when>
            <xsl:when test="@n='c'">
               <xsl:element name="span">
                  <xsl:text> – </xsl:text>
               </xsl:element>
               <xsl:element name="span">
                  <xsl:attribute name="style" select="'vertical-align: super; position: relative; font-family: calibri; font-size: 80%'"/>
                  <xsl:text>c  </xsl:text>
               </xsl:element>
            </xsl:when>
            <xsl:when test="@n='d'">
               <xsl:element name="span">
                  <xsl:text> – </xsl:text>
               </xsl:element>
               <xsl:element name="span">
                  <xsl:attribute name="style" select="'vertical-align: super; position: relative; font-family: calibri; font-size: 80%'"/>
                  <xsl:text>d  </xsl:text>
               </xsl:element>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text></xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
