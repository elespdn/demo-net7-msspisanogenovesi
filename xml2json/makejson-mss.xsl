<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei xs"
    version="2.0">
    <xsl:include href="jsonlib.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:template match="/">
        <xsl:call-template name="main"/>
    </xsl:template>
    <xsl:template name="main">
        <xsl:variable name="docs"
            select="collection('../mss/?select=*.xml;recurse=yes;on-error=warning')"/>
        
        <xsl:variable name="all" as="xs:string+">
            <xsl:for-each select="$docs/TEI/teiHeader">
                <xsl:variable name="p" as="xs:string+">
                    <!--<xsl:value-of select="tei:json('resp',tei:jsonString(.//respStmt/resp),true())"/>
                    <xsl:value-of select="tei:json('respName',tei:jsonString(.//respStmt/name),true())"/>
                    <xsl:value-of select="tei:json('publisher',tei:jsonString(.//publicationStmt/publisher),true())"/>
                    <xsl:value-of select="tei:json('license',tei:jsonString(.//publicationStmt//licence/p),true())"/>
                   --> 
                    <xsl:value-of select="tei:json('msName',tei:jsonString(.//msIdentifier/msName),true())"/>
                    
                    <xsl:for-each select=".//respStmt">
                        <xsl:variable name="resp-items" as="xs:string+">
                            <xsl:value-of select="tei:json('resp',tei:jsonString(resp),true())"/>
                            <xsl:value-of select="tei:json('respName',tei:jsonString(name),true())"/>
                        </xsl:variable>
                        <xsl:variable name="resp">
                            <xsl:value-of select="tei:jsonObject(($resp-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('respStmts',$resp,false())"/>
                    </xsl:for-each>
                    
                    <xsl:for-each select=".//publicationStmt">
                        <xsl:variable name="publication-items" as="xs:string+">
                            <xsl:value-of select="tei:json('publisher',tei:jsonString(publisher),true())"/>
                            <xsl:value-of select="tei:json('licence',tei:jsonString(.//licence/p),true())"/>
                            <xsl:value-of select="tei:json('licenceUrl',tei:jsonString(.//licence/@target),true())"/>
                        </xsl:variable>
                        <xsl:variable name="publication">
                            <xsl:value-of select="tei:jsonObject(($publication-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('publicationStmt',$publication,false())"/>
                    </xsl:for-each>
                    
                    <xsl:for-each select=".//msIdentifier">
                        <xsl:variable name="msId-items" as="xs:string+">
                            <xsl:value-of select="tei:json('country',tei:jsonString(country),true())"/>
                            <xsl:value-of select="tei:json('settlement',tei:jsonString(settlement),true())"/>
                            <xsl:value-of select="tei:json('institution',tei:jsonString(institution),true())"/>
                            <xsl:value-of select="tei:json('repository',tei:jsonString(repository),true())"/>
                            <xsl:value-of select="tei:json('collection',tei:jsonString(collection),true())"/>
                            <xsl:value-of select="tei:json('idno',tei:jsonString(idno),true())"/>
                            <xsl:value-of select="tei:json('msName',tei:jsonString(msName),true())"/>
                        </xsl:variable>
                        <xsl:variable name="msId">
                            <xsl:value-of select="tei:jsonObject(($msId-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('msId',$msId,false())"/>
                    </xsl:for-each>
                    
                    <xsl:for-each select=".//head">
                        <xsl:variable name="head-items" as="xs:string+">
                            <xsl:value-of select="tei:json('title',tei:jsonString(title),true())"/>
                            <xsl:value-of select="tei:json('origPlace',tei:jsonString(origPlace),true())"/>
                            <xsl:value-of select="tei:json('origDate',tei:jsonString(origDate),true())"/>
                            <xsl:value-of select="tei:json('origDate-notBefore',origDate/@notBefore,true())"/>
                            <xsl:value-of select="tei:json('origDate-notAfter',origDate/@notAfter,true())"/>
                        </xsl:variable>
                        <xsl:variable name="head">
                            <xsl:value-of select="tei:jsonObject(($head-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('head',$head,false())"/>
                    </xsl:for-each>
                    
                   
                    <xsl:variable name="msItem">
                        <xsl:for-each select=".//msContents/msItem">
                        <xsl:variable name="msItem-items" as="xs:string+">
                            <xsl:value-of select="tei:json('author',tei:jsonString(author),true())"/>
                            <xsl:value-of select="tei:json('title',tei:jsonString(title),true())"/>
                            <xsl:value-of select="tei:json('incipit',tei:jsonString(incipit),true())"/>
                            <xsl:value-of select="tei:json('explicit',tei:jsonString(explicit),true())"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:jsonObject(($msItem-items))"/>
                    </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="tei:jsonArray('msItem',($msItem),false())"/>
                    
                    
                    <xsl:for-each select=".//objectDesc">
                        <xsl:variable name="objDesc-items" as="xs:string+">
                            <xsl:value-of select="tei:json('support',tei:jsonString(.//support),true())"/>
                            <xsl:value-of select="tei:json('leavesCount',tei:jsonString(.//measure[@type='leavesCount']),true())"/>
                            <xsl:value-of select="tei:json('pageDimentions',tei:jsonString(.//measure[@type='pageDimensions']),true())"/>
                            <xsl:value-of select="tei:json('foliation',tei:jsonString(.//foliation),true())"/>
                            <xsl:value-of select="tei:json('condition',tei:jsonString(.//condition),true())"/>
                        </xsl:variable>
                        <xsl:variable name="objDesc">
                            <xsl:value-of select="tei:jsonObject(($objDesc-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('objectDesc',$objDesc,false())"/>
                    </xsl:for-each>


                    
                </xsl:variable>
                <xsl:value-of select="tei:jsonObject(($p))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="tei:jsonObject(tei:jsonArray('ms',($all),false()))"/>
        
    </xsl:template>
</xsl:stylesheet>
