<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:s="urn:vse.cz:steo08_sem_prace"
    exclude-result-prefixes="xs s" version="2.0"
    xpath-default-namespace="urn:vse.cz:steo08_sem_prace">

    <xsl:output method="html" version="5" encoding="UTF-8"/>
    <xsl:output method="html" name="html5" version="5" encoding="UTF-8"/>
    
    <xsl:param name="TITLE">
        Express Railways
    </xsl:param>

    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link rel="stylesheet" href="style.css"/>
                <title><xsl:value-of select="$TITLE"/></title>
            </head>

            <body>
                <nav class="nav">
                    <div class="nav-container">
                        <img src="logo.png" alt="logo"/>
                        <h1 class="logo"><xsl:value-of select="$TITLE"/></h1>
                    </div>
                </nav>

                <section class="menu-container">
                    <form>
                        <input class="chosen-value" type="text" value="" placeholder="Select User"/>
                        <ul class="value-list">
                            <xsl:apply-templates select="/uzivatele/uzivatel/osobni_udaje"
                                mode="menu"/>
                        </ul>
                    </form>
                </section>

                <xsl:apply-templates select="uzivatele/uzivatel" mode="content"/>

                <footer class="footer">
                    <div class="author">
                        <div class="author-name">Ondřej Štěpán</div>
                        <div class="year">2021</div>
                    </div>
                </footer>

                <xsl:apply-templates select="uzivatele/uzivatel" mode="selecting"/>
                <script src="script.js"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="uzivatele/uzivatel" mode="selecting">
        <xsl:result-document href="{generate-id(.)}.html" format="html5">
            <html lang="en">
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="seznam.css"/>
                    <title><xsl:value-of select="$TITLE"/></title>
                </head>

                <body>
                    <div class="container">
                        <form>
                            <input class="chosen-value" type="text" value=""
                                placeholder="Select ticket"/>
                            <ul class="value-list">
                                <xsl:apply-templates select="jizdenky/jizdenka" mode="selection"/>
                            </ul>
                        </form>
                        <div class="buttons">
                            <a href="semestralniPrace-html.html" class="zpet">Zpět</a>
                            <xsl:apply-templates select="jizdenky/jizdenka" mode="seznam"/>
                        </div>
                    </div>

                    <xsl:apply-templates select="jizdenky/jizdenka" mode="oneByOne"/>
                    <script src="seznam.js"/>
                </body>
            </html>

        </xsl:result-document>
    </xsl:template>

    <xsl:template match="jizdenky/jizdenka" mode="oneByOne">
        <xsl:result-document href="{generate-id(.)}.html" format="html5">
            <html lang="en">
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <link rel="stylesheet" href="detail.css"/>
                    <title><xsl:value-of select="$TITLE"/></title>
                </head>

                <body>
                    <section class="content">
                        <section class="detail-jizdenky">
                            <xsl:if test="nakup">
                                <div class="nakup">
                                    <h3>Objednávka</h3>
                                    <xsl:apply-templates select="nakup/polozky/polozka"/>

                                </div>
                            </xsl:if>
                            <xsl:if test="dotaznik">
                                <div class="hodnoceni">
                                    <h3>Hodnocení cesty</h3>
                                    <div class="hodnoceni-container">
                                        <div class="hodnota"><xsl:value-of select="dotaznik/hodnoceni/celkove"/></div>
                                        <div class="hodnota"><xsl:value-of select="dotaznik/hodnoceni/personal"/></div>
                                        <div class="hodnota"><xsl:value-of select="dotaznik/hodnoceni/cistota"/></div>

                                    </div>
                                    <xsl:if test="dotaznik/komentar">
                                    <h4>Komentář</h4>
                                    <em class="kometar"><xsl:value-of select="dotaznik/komentar"/></em>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                        </section>

                        <section class="jizdenka">
                            <h2 class="informace">Informace o jízdence</h2>
                            <h3 class="id"><xsl:value-of select="trasa/@id_trasy"/></h3>
                            <div class="trasa">
                                <div>
                                    <span class="nadpisy">Datum cesty: </span>
                                    <span><xsl:value-of select="trasa/informace/datum"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Odkud: </span>
                                    <span><xsl:value-of select="trasa/informace/odkud"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Kam: </span>
                                    <span><xsl:value-of select="trasa/informace/kam"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Výjezd: </span>
                                    <span><xsl:value-of select="trasa/informace/vyjezd"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Příjezd: </span>
                                    <span><xsl:value-of select="trasa/informace/prijezd"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Třída: </span>
                                    <span><xsl:value-of select="trasa/informace/trida"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Sedadlo: </span>
                                    <span><xsl:value-of select="trasa/informace/sedadlo/vuz"/></span>
                                    <span><xsl:value-of select="trasa/informace/sedadlo/cislo"/></span>
                                </div>
                            </div>

                            <div class="platba">
                                <div class="nadpisy">Informace o platbě</div>
                                <div>
                                    <span class="nadpisy">Zaplaceno: </span>
                                    <span><xsl:value-of select="trasa/platba/datum"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Cena: </span>
                                    <span><xsl:value-of select="trasa/platba/cena"/><xsl:text> </xsl:text><xsl:value-of select="trasa/platba/cena/@mena"/></span>
                                </div>
                                <div>
                                    <span class="nadpisy">Způsob zaplacení: </span>
                                    <span><xsl:value-of select="trasa/platba/uhrazeno"/></span>
                                </div>
                            </div>
                        </section>
                    </section>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="nakup/polozky/polozka">
        <div class="polozka">
            <div class="nadpisy"><xsl:value-of select="nazev"/></div>
            <div>
                <span class="nadpisy">Cena: </span>
                <span>
                    <xsl:value-of select="cena"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="cena/@mena"/>
                </span>
            </div>
            <div>
                <span class="nadpisy">Způsob zaplacení: </span>
                <span><xsl:value-of select="uhrazeno"/></span>
            </div>
            <div class="id"><xsl:value-of select="@danovy_doklad"/></div>
        </div>
    </xsl:template>

    <xsl:template match="jizdenky/jizdenka" mode="seznam">
        <a href="{generate-id(.)}.html" target="_blank" class="podrobnosti" id="{generate-id(.)}"
            >Detail jízdenky</a>
    </xsl:template>

    <xsl:template match="jizdenky/jizdenka" mode="selection">
        <li id="{generate-id(.)}">
            <xsl:value-of select="trasa/@id_trasy"/>
        </li>
    </xsl:template>

    <xsl:template match="uzivatele/uzivatel" mode="content">
        <div class="content" id="{generate-id(.)}">

            <section class="user-container">
                <span class="first">
                    <xsl:value-of select="osobni_udaje/jmeno"/>
                </span>
                <xsl:text> </xsl:text>
                <span class="last">
                    <xsl:value-of select="osobni_udaje/prijmeni"/>
                </span>
                <div class="ident">
                    <xsl:value-of select="osobni_udaje/@id_uzivatele"/>
                </div>
                <div class="detail-uzivatele">
                    <div>narození: <xsl:value-of select="osobni_udaje/datum"/></div>
                    <div>email: <xsl:value-of select="osobni_udaje/email"/></div>
                    <div>tel: <xsl:value-of select="osobni_udaje/telefon"/></div>
                    <xsl:if test="osobni_udaje/sleva">
                        <div>slevová karta: <xsl:value-of select="osobni_udaje/sleva"/></div>
                    </xsl:if>
                </div>
            </section>

            <xsl:if test="jizdenky">
                <xsl:apply-templates select="jizdenky" mode="posledni"/>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="jizdenky" mode="posledni">
        <xsl:variable name="sorted">
            <xsl:perform-sort select="jizdenka">
                <xsl:sort select="trasa/informace/datum"/>
            </xsl:perform-sort>
        </xsl:variable>

        <section class="jizdenka">
            <h2 class="informace">Poslední jízdenka</h2>
            <h3 class="ident">
                <xsl:value-of select="$sorted/jizdenka[last()]/trasa/@id_trasy"/>
            </h3>
            <div class="trasa">
                <div>
                    <span class="nadpisy">Datum cesty: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/datum"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Odkud: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/odkud"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Kam: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/kam"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Výjezd: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/vyjezd"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Příjezd: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/prijezd"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Třída: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/trida"/>
                    </span>
                </div>
                <div>
                    <span class="nadpisy">Sedadlo: </span>
                    <span>
                        <xsl:value-of select="$sorted/jizdenka[last()]/trasa/informace/sedadlo/vuz"
                        />
                    </span>
                    <span>
                        <xsl:value-of
                            select="$sorted/jizdenka[last()]/trasa/informace/sedadlo/cislo"/>
                    </span>
                </div>
            </div>
            <a href="{generate-id(..)}.html" class="podrobnosti">Další jízdenky</a>
        </section>
    </xsl:template>

    <xsl:template match="uzivatele/uzivatel/osobni_udaje" mode="menu">
        <li id="{generate-id(..)}">
            <xsl:value-of select="jmeno"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="prijmeni"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
