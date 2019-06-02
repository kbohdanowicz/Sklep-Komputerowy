<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="html" encoding="UTF-8"/>
    <xsl:template match="/">
         <xsl:text disable-output-escaping='yes'>
            &lt;!DOCTYPE html/>
        </xsl:text>
        <html>
            <body>
                <h1>Sklep Komputerowy</h1>
                <xsl:comment>VAT wliczony w cenę</xsl:comment>
                <h2>Produkty:</h2>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <td align="center"><b>Nazwa</b></td>
                        <td align="center">Kategoria</td>
                        <td align="center">Cena</td>
                        <td align="center">Producent</td>
                    </tr>
                    <xsl:for-each select="/sklep/produkty/produkt">
                        <xsl:sort select="cena" data-type="number"/>
                        <tr>
                            <td style="color:darkbrown"><b><xsl:value-of select="nazwa"/></b></td>
                            <td style="color:orange"><xsl:value-of select="kategoria"/></td>
                            <td style="color:blue"><u><xsl:value-of select="cena"/></u></td>
                            <xsl:choose>
                                <xsl:when test="producent='Razer'">
                                    <td style="color:green"><i><xsl:value-of select="producent"/></i></td>
                                </xsl:when>
                                <xsl:when test="producent='MSI'">
                                    <td style="color:red"><i><xsl:value-of select="producent"/></i></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td><i><xsl:value-of select="producent"/></i></td>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tr>
                    </xsl:for-each>
                </table>
                <table>
                    <tr>
                        <td><xsl:text>Ilość rodzajów produktów: </xsl:text></td>
                        <td><xsl:value-of select="count(/sklep/produkty/produkt)"/></td>
                    </tr>
                    <tr>
                        <td><xsl:text>Cena wszystkich produktów: </xsl:text></td>
                        <td><xsl:value-of select="sum(/sklep/produkty/produkt/cena/text())"/></td>
                    </tr>
                    <tr>
                        <td><xsl:text>Średnia cena produktów: </xsl:text></td>
                        <td><xsl:value-of select="ceiling(sum(/sklep/produkty/produkt/cena/text()) div count(/sklep/produkty/produkt))"/></td>
                    </tr>
                    <tr>
                        <td><xsl:text>Średnia cena produktów MSI: </xsl:text></td>
                        <td><xsl:value-of select="sum(/sklep/produkty/produkt[producent='MSI']/cena/text()) div count(/sklep/produkty/produkt[producent='MSI'])"/></td>
                    </tr>
                </table>
                <h3><xsl:text>Polecamy!</xsl:text></h3>
                <ul>
                    <xsl:for-each select="/sklep/produkty/produkt[producent='Razer' or cena>=1500]">
                        <xsl:sort select="producent" order="descending"/>
                        <li>
                            <xsl:value-of select="nazwa"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h2>Pracownicy:</h2>
                <table>
                    <tr>
                        <td align="center">Imie</td>
                        <td align="center">Nazwisko</td>
                        <td align="center">Pozycja</td>
                        <td align="center">Pensja</td>
                        <td align="center">Telefon</td>
                    </tr>
                    <xsl:for-each select="/sklep/pracownicy/pracownik">
                        <xsl:if test="@plec='k'">
                            <tr style="color:red">
                                <td><xsl:value-of select="imie"/></td>
                                <td><xsl:value-of select="nazwisko"/></td>
                                <td><xsl:value-of select="pozycja"/></td>
                                <td><xsl:value-of select="pensja"/></td>
                                <td><i><xsl:value-of select="telefon"/></i></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="@plec='m'">
                            <tr style="color:blue">
                                <td><xsl:value-of select="imie"/></td>
                                <td><xsl:value-of select="nazwisko"/></td>
                                <td><xsl:value-of select="pozycja"/></td>
                                <td><xsl:value-of select="pensja"/></td>
                                <td><i><xsl:value-of select="telefon"/></i></td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>