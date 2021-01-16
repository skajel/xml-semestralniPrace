<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="urn:vse.cz:steo08_sem_prace" prefix="s"/>
                 
    <sch:pattern>
        <sch:title>Kontrola datumu narození</sch:title>        
        <sch:rule context="s:uzivatel/s:uzivatel/s:osobni_udaje/s:datum">           
            <sch:assert test="current() &lt; ../../s:jizdenky/s:jizdenka/s:trasa/s:informace/s:datum">Datum narození musí být menší než datum cesty</sch:assert>            
        </sch:rule>       
    </sch:pattern>  
    
    <sch:pattern>
        <sch:title>Kontrola datumu nákupu</sch:title>        
        <sch:rule context="s:uzivatele/s:uzivatel/s:jizdenky/s:jizdenka/s:trasa/s:informace/s:datum">           
            <sch:assert test="current() &gt;= ../../s:platba/s:datum">Datum cesty musí být větší nebo rovno datumu nákupu</sch:assert>            
        </sch:rule>       
    </sch:pattern>  
</sch:schema>