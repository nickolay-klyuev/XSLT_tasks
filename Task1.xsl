<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

	<touristInfo>

		<xsl:for-each select="list/tourists">
			<touristGroup>
				<xsl:call-template name="test">
				</xsl:call-template>
			</touristGroup>
		</xsl:for-each>

	</touristInfo>

</xsl:template>

<xsl:template name="test">
	<xsl:param name="group-string" select="text()" />
	
	<xsl:call-template name="test2">
		<xsl:with-param name="string" select="$group-string" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="test2">
	<xsl:param name="string" />
	<xsl:param name="string-before" select="substring-before($string, '|')" />
	<xsl:param name="string-after" select="substring-after($string, '|')" />

	<xsl:call-template name="test3">
		<xsl:with-param name="tourist-string" select="$string-before" />
	</xsl:call-template>

	<xsl:if test="$string-after != ''">
		<xsl:call-template name="test2">
			<xsl:with-param name="string" select="$string-after" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="test3">
	<xsl:param name="tourist-string" />
	<xsl:param name="tourist-string-before" select="substring-before($tourist-string, '/')" />
	<xsl:param name="tourist-string-after" select="substring-after($tourist-string, '/')" />

	<xsl:if test="$tourist-string-before = 10">
		<tourist type="ADT"></tourist>
	</xsl:if>
	<xsl:if test="$tourist-string-before = 8">
		<tourist type="CHD"></tourist>
	</xsl:if>
	<xsl:if test="$tourist-string-before = 7">
		<tourist type="INF"></tourist>
	</xsl:if>
</xsl:template>
	
</xsl:stylesheet>