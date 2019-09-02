<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/MARIOKART">
        <RESULTS>
            <xsl:for-each select="./characters/character/name | ./gliders/glider/name | ./bodies/body/name | ./tires/tire/name">
                <xsl:sort select="."/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </RESULTS>   
    </xsl:template>
</xsl:stylesheet>