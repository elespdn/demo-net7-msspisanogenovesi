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
                    <xsl:value-of
                        select="tei:json('msName',tei:jsonString(.//msIdentifier/msName),true())"/>

                    <xsl:for-each select=".//respStmt">
                        <xsl:variable name="resp-items" as="xs:string+">
                            <xsl:value-of select="tei:json('Task',tei:jsonString(resp),true())"/>
                            <xsl:value-of select="tei:json('Name',tei:jsonString(name),true())"/>
                        </xsl:variable>
                        <xsl:variable name="resp">
                            <xsl:value-of select="tei:jsonObject(($resp-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('respStmt',$resp,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//publicationStmt">
                        <xsl:variable name="publication-items" as="xs:string+">
                            <xsl:value-of
                                select="tei:json('Publisher',tei:jsonString(publisher),true())"/>
                            <xsl:value-of
                                select="tei:json('Licence',tei:jsonString(.//licence/p),true())"/>
                            <xsl:value-of
                                select="tei:json('Licence link',tei:jsonString(.//licence/@target),true())"
                            />
                        </xsl:variable>
                        <xsl:variable name="publication">
                            <xsl:value-of select="tei:jsonObject(($publication-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('publicationStmt',$publication,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//msIdentifier">
                        <xsl:variable name="msId-items" as="xs:string+">
                            <xsl:value-of
                                select="tei:json('Country',tei:jsonString(country),true())"/>
                            <xsl:value-of
                                select="tei:json('City',tei:jsonString(settlement),true())"/>
                            <xsl:value-of
                                select="tei:json('Institution',tei:jsonString(institution),true())"/>
                            <xsl:value-of
                                select="tei:json('Repository',tei:jsonString(repository),true())"/>
                            <xsl:value-of
                                select="tei:json('Collection',tei:jsonString(collection),true())"/>
                            <xsl:value-of
                                select="tei:json('Identifier',tei:jsonString(idno),true())"/>
                            <xsl:value-of
                                select="tei:json('Manuscript name',tei:jsonString(msName),true())"/>
                        </xsl:variable>
                        <xsl:variable name="msId">
                            <xsl:value-of select="tei:jsonObject(($msId-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('msId',$msId,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//head">
                        <xsl:variable name="head-items" as="xs:string+">
                            <xsl:value-of select="tei:json('Title',tei:jsonString(title),true())"/>
                            <xsl:value-of
                                select="tei:json('Place of origin',tei:jsonString(origPlace),true())"/>
                            <xsl:value-of
                                select="tei:json('Date of origin',tei:jsonString(origDate),true())"/>
                            <xsl:value-of
                                select="tei:json('Terminus post quem',origDate/@notBefore,true())"/>
                            <xsl:value-of
                                select="tei:json('Terminus ante quem',origDate/@notAfter,true())"/>
                        </xsl:variable>
                        <xsl:variable name="head">
                            <xsl:value-of select="tei:jsonObject(($head-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('head',$head,false())"/>
                    </xsl:for-each>


                    <xsl:variable name="msItem">
                        <xsl:for-each select=".//msContents/msItem">
                            <xsl:variable name="msItem-items" as="xs:string+">
                                <xsl:value-of
                                    select="tei:json('Author',tei:jsonString(author),true())"/>
                                <xsl:value-of
                                    select="tei:json('Title',tei:jsonString(title),true())"/>
                                <xsl:value-of
                                    select="tei:json('Incipit',tei:jsonString(incipit),true())"/>
                                <xsl:value-of
                                    select="tei:json('Explicit',tei:jsonString(explicit),true())"/>
                            </xsl:variable>
                            <xsl:value-of select="tei:jsonObject(($msItem-items))"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="tei:jsonArray('msItem',($msItem),false())"/>


                    <xsl:for-each select=".//objectDesc">
                        <xsl:variable name="objDesc-items" as="xs:string+">
                            <xsl:value-of
                                select="tei:json('Support',tei:jsonString(.//support),true())"/>
                            <xsl:value-of
                                select="tei:json('Number of leaves',tei:jsonString(.//measure[@type='leavesCount']),true())"/>
                            <xsl:value-of
                                select="tei:json('Dimension of pages',tei:jsonString(.//measure[@type='pageDimensions']),true())"/>
                            <xsl:value-of
                                select="tei:json('Foliation',tei:jsonString(.//foliation),true())"/>
                            <xsl:value-of
                                select="tei:json('Condition',tei:jsonString(.//condition),true())"/>
                        </xsl:variable>
                        <xsl:variable name="objDesc">
                            <xsl:value-of select="tei:jsonObject(($objDesc-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('objectDesc',$objDesc,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//handDesc">
                        <xsl:variable name="handDesc-items" as="xs:string+">
                            <xsl:value-of
                                select="tei:json('Scribe',tei:jsonString(.//handNote[@xml:id='copista']),true())"/>
                            <xsl:if test=".//handNote[@xml:id='didascalie']"><xsl:value-of
                                select="tei:json('Captions scribe',tei:jsonString(.//handNote[@xml:id='didascalie']),true())"
                            /></xsl:if>
                        </xsl:variable>
                        <xsl:variable name="handDesc">
                            <xsl:value-of select="tei:jsonObject(($handDesc-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('handDesc',$handDesc,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//scriptDesc">
                        <xsl:variable name="scriptDesc-items" as="xs:string+">
                            <xsl:value-of
                                select="tei:json('Script',tei:jsonString(.//scriptNote),true())"/>
                        </xsl:variable>
                        <xsl:variable name="scriptDesc">
                            <xsl:value-of select="tei:jsonObject(($scriptDesc-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('scriptDesc',$scriptDesc,false())"/>
                    </xsl:for-each>

                    <xsl:for-each select=".//decoDesc">
                        <xsl:variable name="decoDesc-items" as="xs:string+">
                            <xsl:if test=".//decoNote[@type='filigranata']">
                                <xsl:value-of
                                    select="tei:json('Pen flourished initials',tei:jsonString(.//decoNote[@type='filigranata']),true())"/></xsl:if>
                            <xsl:if test=".//decoNote[@type='ornata']">
                                <xsl:value-of
                                select="tei:json('Decorated initials',tei:jsonString(.//decoNote[@type='ornata']),true())"/></xsl:if>
                            <xsl:if test=".//decoNote[@type='istoriata']">
                                <xsl:value-of
                                select="tei:json('Historiated initials',tei:jsonString(.//decoNote[@type='istoriata']),true())"/></xsl:if>
                            <xsl:if test=".//decoNote[@type='miniatura']">
                                <xsl:value-of
                                select="tei:json('Illuminations',tei:jsonString(.//decoNote[@type='miniatura']),true())"
                            /></xsl:if>
                        </xsl:variable>
                        <xsl:variable name="decoDesc">
                            <xsl:value-of select="tei:jsonObject(($decoDesc-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('decoDesc',$decoDesc,false())"/>
                    </xsl:for-each>
                    
                    
                    <xsl:if test=".//additions">
                        <xsl:variable name="additions-items" as="xs:string+">
                            <xsl:value-of select="tei:json('Additional writing or drawing',tei:jsonString(.//additions),true())"/>
                        </xsl:variable>
                        <xsl:variable name="additions">
                            <xsl:value-of select="tei:jsonObject(($additions-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('additions',$additions,false())"/>
                    </xsl:if>
                    
                    <xsl:if test=".//additional">
                        <xsl:variable name="additional-items" as="xs:string+">
                            <xsl:value-of select="tei:json('Surrogates',tei:jsonString(//additional/surrogates/node()[not(self::ref)]),true())"/>
                            <xsl:value-of select="tei:json('Link',tei:jsonString(//additional/surrogates/ref),true())"/>
                            <xsl:value-of select="tei:json('LinkUrl',tei:jsonString(//additional/surrogates/ref/@target),true())"/>
                        </xsl:variable>
                        <xsl:variable name="additional">
                            <xsl:value-of select="tei:jsonObject(($additional-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('additional',$additional,false())"/>
                    </xsl:if>
                    
                    <!-- Here I want to create an array, but cannot -->
                    <xsl:for-each select=".//listBibl/bibl">
                        <xsl:variable name="bibl-items" as="xs:string+">
                            <xsl:if test="author">
                                <xsl:choose>
                                    <xsl:when test=".[author[1] and author[2] and author[3]]">
                                        <xsl:value-of
                                            select="tei:json('author',tei:jsonString(concat(author[1],', ',author[2],', ',author[3])),true())"
                                        />
                                    </xsl:when>
                                    <xsl:when test=".[author[1] and author[2]]">
                                        <xsl:value-of
                                            select="tei:json('author',tei:jsonString(concat(author[1],', ',author[2])),true())"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of
                                            select="tei:json('author',tei:jsonString(author),true())"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                            <xsl:value-of select="tei:json('date',tei:jsonString(./date),true())"/>
                        </xsl:variable>
                        <xsl:variable name="bibl">
                            <xsl:value-of select="tei:jsonObject(($bibl-items))"/>
                        </xsl:variable>
                        <xsl:value-of select="tei:json('bibl',$bibl,false())"/>
                    </xsl:for-each>


                </xsl:variable>
                <xsl:value-of select="tei:jsonObject(($p))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="tei:jsonObject(tei:jsonArray('ms',($all),false()))"/>

    </xsl:template>
</xsl:stylesheet>
