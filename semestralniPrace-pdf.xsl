<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:s="urn:vse.cz:steo08_sem_prace"
    exclude-result-prefixes="xs s"
    version="2.0"
    xpath-default-namespace="urn:vse.cz:steo08_sem_prace">
    
    <xsl:output method="xml" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="my-page" page-height="210mm" page-width="297mm" margin="30px">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="my-page">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <xsl:template match="uzivatel">
        <fo:block>Uživatel</fo:block>
            <xsl:apply-templates select="osobni_udaje"/>
        
    </xsl:template>
    
    <xsl:template match="osobni_udaje">
        <fo:block><xsl:value-of select="jmeno"/></fo:block>
        <fo:block>Datum narozeni - <xsl:value-of select="datum"/></fo:block>
        <fo:block>Email - <xsl:value-of select="email"/></fo:block>
        <fo:block>Telefon - <xsl:value-of select="email"/></fo:block>
        
    </xsl:template>
    
    
</xsl:stylesheet>