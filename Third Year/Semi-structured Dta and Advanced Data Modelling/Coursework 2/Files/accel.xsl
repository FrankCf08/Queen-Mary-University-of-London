<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="MARIOKART">
    <results>
        <xsl:for-each-group select="characters/character" group-by="accel">
            <xsl:sort select="accel"/>
            <result>
                <xsl:attribute name="accel">
                    <xsl:value-of select="current-grouping-key()"/>
                </xsl:attribute>
                 <xsl:for-each select="current-group()">
                     <xsl:copy-of select="name"/>
                 </xsl:for-each>
            </result>
        </xsl:for-each-group>
    </results>
    </xsl:template>
</xsl:stylesheet>