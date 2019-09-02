<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="MARIOKART">
        <RESULTS>
            <xsl:for-each select="bodies/body">
                <xsl:variable name="bodiesName" select="name"/>
                <xsl:variable name="bodySpeed" select="speed/land"/>
                <xsl:for-each-group select="/MARIOKART/tires/tire" group-by="name">
                    <xsl:variable name="tireSpeed" select="speed/land"/>
                     <result>
                        <tire><xsl:value-of select="name"/></tire>
                        <body><xsl:value-of select="$bodiesName"/></body>
                        <speed><xsl:value-of select="$bodySpeed+$tireSpeed"/></speed>
                     </result>
                </xsl:for-each-group>          
            </xsl:for-each>
        </RESULTS>
    </xsl:template>
</xsl:stylesheet>