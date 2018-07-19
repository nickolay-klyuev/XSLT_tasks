<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">



	<xsl:variable name="str1" select="string(root/str1)" />
	<xsl:variable name="str2" select="string(root/str2)" />
	<xsl:variable name="str3" select="string(root/str3)" />
	<xsl:variable name="str4" select="string(root/str4)" />

	<xsl:call-template name="reverse">
		<xsl:with-param name="input" select="$str1" />
	</xsl:call-template>

	<xsl:call-template name="numbers">
		<xsl:with-param name="input" select="$str2" />
	</xsl:call-template>

	<xsl:call-template name="without-numbers">
		<xsl:with-param name="input" select="$str3" />
	</xsl:call-template>

	<xsl:call-template name="space">
		<xsl:with-param name="input" select="$str4" />
	</xsl:call-template>

</xsl:template>

<xsl:template name="reverse">
     <xsl:param name="input"/>
     <xsl:variable name="len" select="string-length($input)"/>
     <xsl:choose>
          <!-- Strings of length less than 2 are trivial to reverse -->
          <xsl:when test="$len &lt; 2">
               <xsl:value-of select="$input"/>
          </xsl:when>
          <!-- Strings of length 2 are also trivial to reverse -->
          <xsl:when test="$len = 2">
               <xsl:value-of select="substring($input,2,1)"/>
               <xsl:value-of select="substring($input,1,1)"/>
          </xsl:when>
          <xsl:otherwise>
               <!-- Swap the recursive application of this template to 
               the first half and second half of input -->
               <xsl:variable name="mid" select="floor($len div 2)"/>
               <xsl:call-template name="reverse">
                    <xsl:with-param name="input"
                         select="substring($input,$mid+1,$mid+1)"/>
               </xsl:call-template>
               <xsl:call-template name="reverse">
                    <xsl:with-param name="input"
                         select="substring($input,1,$mid)"/>
               </xsl:call-template>
          </xsl:otherwise>
     </xsl:choose>
</xsl:template>

<xsl:template name="numbers">
	<xsl:param name="input" />
	<xsl:value-of select="translate($input, translate($input,'0123456789', ''), '')" />
</xsl:template>

<xsl:template name="without-numbers">
	<xsl:param name="input" />
	<xsl:value-of select="translate($input, '0123456789', '')" />
</xsl:template>

<xsl:template name="space">
	<xsl:param name="input" />
	<xsl:variable name="space" select="'&#032;&#010;'"/>
	<xsl:value-of select="string-length($input) - string-length(translate($input, $space, ''))" />
</xsl:template>

</xsl:stylesheet>