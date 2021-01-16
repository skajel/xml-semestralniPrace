<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:s="urn:vse.cz:steo08_sem_prace" exclude-result-prefixes="xs s" version="2.0"
    xpath-default-namespace="urn:vse.cz:steo08_sem_prace">

    <xsl:output method="xml" encoding="UTF-8"/>

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="my-page" page-height="210mm" page-width="297mm"
                    margin="30px">
                    <fo:region-body margin="70px" region-name="xsl-region-body"/>
                    <fo:region-before extent="2cm" region-name="xsl-region-before"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


            <fo:page-sequence master-reference="my-page">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-weight="600" font-size="45px" color="#222" text-align="center">
                        <fo:external-graphic src="logo.png" content-height="scale-to-fit"
                            content-width="scale-to-fit" height="35px" width="35px"
                            scaling="non-uniform"/> EXPRESS RAILWAYS </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="/uzivatele/uzivatel"/>
                    <xsl:apply-templates select="/uzivatele/uzivatel/jizdenky/jizdenka" mode="all"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>



    <xsl:template match="uzivatel">
        <fo:block border="2px solid #222" padding-left="50px" padding-top="20px"
            padding-bottom="20px" background-color="#222" color="#e0e0e0" margin="30px"
            page-break-inside="avoid"
            >
            <fo:block font-weight="600" font-size="18px" margin-bottom="5px">uživatel <xsl:value-of
                    select="osobni_udaje/@id_uzivatele"/></fo:block>
            <fo:block font-weight="600">
                <xsl:value-of select="osobni_udaje/jmeno"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="osobni_udaje/prijmeni"/>
            </fo:block>
            <fo:block>datum narozeni: <xsl:value-of select="osobni_udaje/datum"/></fo:block>
            <fo:block>email: <xsl:value-of select="osobni_udaje/email"/></fo:block>
            <fo:block>telefon: <xsl:value-of select="osobni_udaje/telefon"/></fo:block>
            <xsl:if test="osobni_udaje/sleva">
                <fo:block>sleva: <xsl:value-of select="osobni_udaje/sleva"/></fo:block>
            </xsl:if>
            <xsl:apply-templates select="jizdenky"/>
        </fo:block>
        


    </xsl:template>

    <xsl:template match="jizdenky">
        
        <fo:block background-color="#e0e0e0" color="#222" margin="20px 60px 20px 10px"
            padding="30px">
            <xsl:apply-templates select="jizdenka" mode="seznam"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="jizdenka" mode="seznam">
        <fo:block>
        <fo:basic-link internal-destination="{generate-id(.)}">
            <xsl:value-of select="trasa/@id_trasy"/>
        </fo:basic-link>
        </fo:block>
    </xsl:template>

    <xsl:template match="jizdenka" mode="all">
        
        <fo:block id="{generate-id(.)}"  
            page-break-before="always" >
            <fo:block margin-bottom="10px" background-color="#e0e0e0" padding="20px" border="2px solid #222">
                <fo:block font-weight="600">jízdenka č. <xsl:value-of select="trasa/@id_trasy"/></fo:block>
                <fo:block>datum cesty: <xsl:value-of select="trasa/informace/datum"/></fo:block>
                <fo:block>odkud: <xsl:value-of select="trasa/informace/odkud"/></fo:block>
                <fo:block>kam: <xsl:value-of select="trasa/informace/kam"/></fo:block>
                <fo:block>výjezd: <xsl:value-of select="trasa/informace/vyjezd"/></fo:block>
                <fo:block>příjezd: <xsl:value-of select="trasa/informace/prijezd"/></fo:block>
                <fo:block>třída: <xsl:value-of select="trasa/informace/trida"/></fo:block>
                <fo:block>sedadlo: <xsl:value-of select="trasa/informace/sedadlo/vuz"/>
                    <xsl:value-of select="trasa/informace/sedadlo/cislo"/></fo:block>
            </fo:block>

            <fo:block background-color="#e0e0e0" padding="20px" border="2px solid #222" margin-bottom="10px">
                <fo:block font-weight="600">Platba</fo:block>
                <fo:block>datum: <xsl:value-of select="trasa/platba/datum"/></fo:block>
                <fo:block>cena: <xsl:value-of select="trasa/platba/cena"/>
                    <xsl:value-of select="trasa/platba/cena/@mena"/></fo:block>
                <fo:block>uhrazeno: <xsl:value-of select="trasa/platba/uhrazeno"/></fo:block>
            </fo:block>


            <xsl:if test="nakup">
                <fo:block background-color="#e0e0e0" padding="20px" border="2px solid #222" margin-bottom="10px">
                    <fo:block font-weight="600">Nákup</fo:block>
                <xsl:apply-templates select="nakup/polozky"/>
                </fo:block>
            </xsl:if>
            <xsl:if test="dotaznik">
                <fo:block background-color="#e0e0e0" padding="20px" border="2px solid #222" margin-bottom="10px">
                    <fo:block font-weight="600">Dotazník</fo:block>
                <xsl:apply-templates select="dotaznik"/>
                </fo:block>
            </xsl:if>
            

            
            
        </fo:block>
    </xsl:template>
    
    <xsl:template match="polozky">
        <fo:table>
            <fo:table-header>
                <fo:table-row font-weight="600" font-size="15px">
                    <fo:table-cell>
                        <fo:block>ID</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>Produkt</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>Cena</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>Uhrazeno</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:apply-templates select="polozka"/>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <xsl:template match="polozka">
        <fo:table-row>
            <fo:table-cell padding-right="25px">
                <fo:block><xsl:value-of select="@danovy_doklad"/></fo:block>
            </fo:table-cell>
            <fo:table-cell padding-right="25px">
                <fo:block><xsl:value-of select="nazev"/></fo:block>
            </fo:table-cell>
            <fo:table-cell padding-right="25px">
                <fo:block><xsl:value-of select="cena"/></fo:block>
            </fo:table-cell>
            <fo:table-cell padding-right="25px">
                <fo:block><xsl:value-of select="uhrazeno"/></fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="dotaznik">
        <fo:block>celkově: <xsl:value-of select="hodnoceni/celkove"/></fo:block>
        <fo:block>personál: <xsl:value-of select="hodnoceni/personal"/></fo:block>
        <fo:block>čistota: <xsl:value-of select="hodnoceni/cistota"/></fo:block>
        <xsl:if test="komentar">
            <fo:block><xsl:value-of select="komentar"/></fo:block>
        </xsl:if>
        
    </xsl:template>


</xsl:stylesheet>
