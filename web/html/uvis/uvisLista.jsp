<%@ page 

import="java.io.File"


import="com.healthmarketscience.jackcess.Database"
import="com.healthmarketscience.jackcess.Database"
import="com.healthmarketscience.jackcess.DatabaseBuilder"
import="com.healthmarketscience.jackcess.query.Query"
import="com.healthmarketscience.jackcess.Table"
import="com.healthmarketscience.jackcess.Row"
import="java.sql.*"

contentType="text/html" 
pageEncoding="UTF-8"

%><%

%><!DOCTYPE html>
<!--
Copyright (c) 2021, /WELLSampaio <github.com/wsampaio>
Todos os direitos reservados.

Redistribuicao e uso em formatos de origem e binarios, com ou sem
modificacoes, são permitidas desde que as seguintes condicoes sejam atendidas:

* As redistribuições do codigo-fonte devem manter o aviso de copyright acima, 
esta lista de condicoes e a seguinte isencao de responsabilidade.
* As redistribuições em formato binario devem reproduzir o aviso de copyright 
acima, esta lista de condicoes e a seguinte isencaoo de responsabilidade na 
documentacao e / ou outros materiais fornecidos com a distribuicao.

ESTE SOFTWARE E FORNECIDO PELOS PROPRIETARIOS DOS DIREITOS AUTORAIS E 
CONTRIBUIDORES "NO ESTADO EM QUE SE ENCONTRA" E QUAISQUER GARANTIAS EXPRESSAS 
OU IMPLICITAS, INCLUINDO, MAS NAO SE LIMITANDO A, GARANTIAS IMPLICITAS DE 
COMERCIALIZACAO E ADEQUACAO A UM DETERMINADO FIM SAO REJEITADAS. EM NENHUMA 
HIPOTESE O TITULAR DOS DIREITOS AUTORAIS OU CONTRIBUIDORES SERA RESPONSAVEL POR 
QUAISQUER DANOS DIRETOS, INDIRETOS, INCIDENTAIS, ESPECIAIS, EXEMPLARES OU 
CONSEQUENCIAIS (INCLUINDO, MAS NAO SE LIMITANDO A, AQUISICAO DE BENS OU 
SERVICOS SUBSTITUTOS; PERDA DE USO, DADOS OU SERVICOS; OU INTERRUPCAO DE 
NEGOCIOS) NO ENTANTO CAUSADA E EM QUALQUER TEORIA DE RESPONSABILIDADE, SEJA EM 
CONTRATO, RESPONSABILIDADE ESTRITA OU DELITO (INCLUINDO NEGLIGENCIA OU OUTRO) 
DECORRENTE DE QUALQUER FORMA DO USO DESTE SOFTWARE, MESMO SE AVISADO DA 
POSSIBILIDADE DE TAIS DANOS.
-->
<html>
<head>
<title>UVIS lista</title>
<style>
  table {
	border-collapse: collapse;
  }
  table td, table th {
	border: 1px solid black;
  }
</style>
</head>

<body>

<%


String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");

String dbFile = diretorioDB + "uvis.mdb";
String user="", password="";

Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");

Connection conn=DriverManager.getConnection("jdbc:ucanaccess://" + dbFile);
Statement s = conn.createStatement();

ResultSet rs = s.executeQuery(
    "SELECT * " +
    "FROM tabela_uvis " +
    ";"
);


%>
<table>
    <thead>
        <tr>
            <th>uvis</th>
            <th>ponto_sei</th>
            <th>email</th>
        </tr>
    </thead>
    <tbody><%
        
        while (rs.next()) {
%>
        
        <tr>
            <td>
			  <a href="./uvis.jsp?cod=<%out.println(rs.getString("cod_uvis"));%>" target="_blank">
				<%out.println(rs.getString("uvis"));%>
			  </a>
			</td>
            <td><%out.println(rs.getString("ponto_sei"));%></td>
            <td><%out.println(rs.getString("email"));%></td>
        </tr><%
            
        }
%>
    </tbody>
</table>
</body>

</html>