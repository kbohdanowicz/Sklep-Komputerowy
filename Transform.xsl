<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="html" encoding="UTF-8"/>
    <xsl:template match="/">
         <xsl:text disable-output-escaping='yes'>
            &lt;!DOCTYPE html/>
        </xsl:text>
        <html>
            <head>
                <style>
                    li {
                        font-family: "Courier New";
                        font-size: 18px;
                    }
                    table {
                        font-family: "Georgia";
                        font-size: 18px;
                        border: 3px solid black;
                        margin: 10px;
                        background-color: burlywood;
                    }
                    h1 {
                        color: royalblue;
                        font-size: 48px;
                        font-family: "Comic Sans MS";
                    }
                    .centerText {
                        margin: auto;
                        width: 40%;
                        text-align: center;
                        padding: 10px;
                    }
                    .centerTable {
                    margin: auto;
                    width: 40%;
                    padding: 10px;
                    }
                    .centerStats {
                    margin: auto;
                    margin-top: 20px;
                    padding: 10px;
                    }
                </style>
            </head>
            <body>
                <xsl:comment>VAT wliczony w cenę</xsl:comment>
                <h1 class="centerText">Sklep Komputerowy</h1>
                <h2 class="centerText">Produkty:</h2>
                <table class="centerTable">
                    <tr bgcolor="#9acd32">
                        <td align="center"><b>Nazwa</b></td>
                        <td align="center">Kategoria</td>
                        <td align="center">Cena</td>
                        <td align="center">Producent</td>
                    </tr>
                    <xsl:for-each select="/sklep/produkty/produkt">
                        <xsl:sort select="cena" data-type="number"/>
                        <tr>
                            <td><b><xsl:value-of select="nazwa"/></b></td>
                            <td style="color:brown"><xsl:value-of select="kategoria"/></td>
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
                <table class="centerStats">
                    <tr>
                        <td><xsl:text>Ilość rodzajów produktów: </xsl:text></td>
                        <td><xsl:value-of select="count(/sklep/produkty/produkt)"/></td>
                    </tr>
                    <tr>
                        <td><xsl:text>Cena wszystkich produktów: </xsl:text></td>
                        <td>
                            <xsl:value-of select="sum(/sklep/produkty/produkt/cena/text())"/>
                            <xsl:value-of select="/sklep/waluty/waluta[@id='PLN']/text()"/>
                        </td>

                    </tr>
                    <tr>
                        <td><xsl:text>Średnia cena produktów: </xsl:text></td>
                        <td>
                            <xsl:value-of select="ceiling(sum(/sklep/produkty/produkt/cena/text()) div count(/sklep/produkty/produkt))"/>
                            <xsl:value-of select="/sklep/waluty/waluta[@id='PLN']/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <td><xsl:text>Średnia cena produktów MSI: </xsl:text></td>
                        <td>
                            <xsl:value-of select="sum(/sklep/produkty/produkt[producent='MSI']/cena/text()) div count(/sklep/produkty/produkt[producent='MSI'])"/>
                            <xsl:value-of select="/sklep/waluty/waluta[@id='PLN']/text()"/>
                        </td>
                    </tr>
                </table>
                <h3 class="centerTable"><xsl:text>Polecamy!</xsl:text></h3>
                <ul class="centerTable">
                    <xsl:for-each select="/sklep/produkty/produkt[producent='Razer' or cena>=1500]">
                        <xsl:sort select="producent" order="descending"/>
                        <li>
                            <xsl:value-of select="nazwa"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h2 class="centerTable">Pracownicy:</h2>
                <table class="centerTable">
                    <tr bgcolor="#06c082">
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
                                <xsl:if test="pensja/@waluta='PLN'">
                                    <td>
                                        <xsl:value-of select="pensja"/>
                                        <xsl:value-of select="/sklep/waluty/waluta[@id='PLN']/text()"/>
                                    </td>
                                </xsl:if>
                                <xsl:if test="pensja/@waluta='USD'">
                                    <td>
                                        <xsl:value-of select="/sklep/waluty/waluta[@id='USD']/text()"/>
                                        <xsl:value-of select="pensja"/>
                                    </td>
                                </xsl:if>
                                <td><i><xsl:value-of select="telefon"/></i></td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="@plec='m'">
                            <tr style="color:blue">
                                <td><xsl:value-of select="imie"/></td>
                                <td><xsl:value-of select="nazwisko"/></td>
                                <td><xsl:value-of select="pozycja"/></td>
                                <xsl:if test="pensja/@waluta='PLN'">
                                    <td>
                                        <xsl:value-of select="pensja"/>
                                        <xsl:value-of select="/sklep/waluty/waluta[@id='PLN']/text()"/>
                                    </td>
                                </xsl:if>
                                <xsl:if test="pensja/@waluta='USD'">
                                    <td>
                                        <xsl:value-of select="/sklep/waluty/waluta[@id='USD']/text()"/>
                                        <xsl:value-of select="pensja"/>
                                    </td>
                                </xsl:if>
                                <td><i><xsl:value-of select="telefon"/></i></td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>