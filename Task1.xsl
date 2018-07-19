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
	<xsl:param name="type-code" select="substring-before($tourist-string, '/')" />
	<xsl:param name="after-type-code" select="substring-after($tourist-string, '/')" />
	<xsl:param name="birth-date" select="substring-before($after-type-code, '/')" />
	<xsl:param name="after-birth-date" select="substring-after($after-type-code, '/')" />
	<xsl:param name="surname" select="substring-before($after-birth-date, '/')" />
	<xsl:param name="after-surname" select="substring-after($after-birth-date, '/')" />
	<xsl:param name="name" select="substring-before($after-surname, '/')" />
	<xsl:param name="prefix" select="substring-after($after-surname, '/')" />

	<tourist>
		<xsl:if test="$type-code = 10">
			<xsl:attribute name="type">ADT</xsl:attribute>
		</xsl:if>
		<xsl:if test="$type-code = 8">
			<xsl:attribute name="type">CHD</xsl:attribute>
		</xsl:if>
		<xsl:if test="$type-code = 7">
			<xsl:attribute name="type">INF</xsl:attribute>
		</xsl:if>

		<xsl:if test="$birth-date != 'null'">
			<xsl:attribute name="birthDate"><xsl:value-of select="$birth-date" /></xsl:attribute>
		</xsl:if>

		<prefix>
			<xsl:value-of select="$prefix" />
		</prefix>
		<name>
			<xsl:value-of select="$name" />
		</name>
		<surname>
			<xsl:value-of select="$surname" />
		</surname>
	</tourist>
</xsl:template>
	
</xsl:stylesheet>