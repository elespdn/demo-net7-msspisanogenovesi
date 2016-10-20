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
            select="collection('../biblio/?select.xml;recurse=yes;on-error=warning')"/>
        <xsl:variable name="all" as="xs:string+">
            <xsl:for-each select="$docs/TEI/text/body/listBibl/bibl">
                <xsl:variable name="p" as="xs:string+">

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
                    
                    <xsl:if test="title[@level='a']">
                        <xsl:value-of
                            select="tei:json('title_article',tei:jsonString(title[@level='a']),true())"
                        />
                    </xsl:if>
                    <xsl:if test="title[@level='m']">
                        <xsl:value-of
                            select="tei:json('title_book',tei:jsonString(title[@level='m']),true())"
                        />
                    </xsl:if>

                    <xsl:if test="editor">
                        <xsl:choose>
                            <xsl:when test=".[editor[1] and editor[2]]">
                                <xsl:value-of
                                    select="tei:json('editor',tei:jsonString(concat(editor[1],', ',editor[2])),true())"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="tei:json('editor',tei:jsonString(editor),true())"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>

                    <xsl:value-of select="tei:json('publisher',tei:jsonString(publisher),true())"/>
                    <xsl:value-of select="tei:json('pubPlace',tei:jsonString(pubPlace),true())"/>
                    <xsl:value-of select="tei:json('date',date,true())"/>
                    <xsl:if test="biblScope">
                        <xsl:value-of select="tei:json('pages',concat('pp. ',biblScope),true())"/>
                    </xsl:if>
                </xsl:variable>
                <xsl:value-of select="tei:jsonObject(($p))"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="tei:jsonObject(tei:jsonArray('bibl',($all),false()))"/>
    </xsl:template>
</xsl:stylesheet>
