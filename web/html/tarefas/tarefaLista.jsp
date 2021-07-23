<%@ page 

import="java.io.File"

import="com.wsampaio.jdbc.ConnDB"

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
<title>Lista tarefas</title>
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


String DBFolder = getServletContext().getInitParameter("diretorioBD");
String schema = "uvis";
String user="", password="";

Connection conn = new ConnDB().getACCConn(DBFolder, schema);
//DriverManager.getConnection("jdbc:ucanaccess://" + dbFile);
Statement s = conn.createStatement();

ResultSet rs = s.executeQuery(
    "SELECT * " +
    "FROM tarefas " +
    ";"
);


%>
<table>
    <thead>
        <tr>
            <th>cod_tarefa</th>
            <th>tarefa</th>
            <th>tarefa</th>
            <th>tarefa</th>
        </tr>
    </thead>
    <tbody><%
        
        while (rs.next()) {
%>
        
        <tr>
            <td>
			  <a href="./tarefa.jsp?cod=<%out.println(rs.getString("cod_tarefa"));%>" target="_blank">
				<%out.println(rs.getString("cod_tarefa"));%>
			  </a>
			</td>
            <td><%out.println(rs.getString("tarefa"));%></td>
            <td>
							<a href="./seguePasso.html?params=<%out.println(rs.getString("cod_primeiro_passo"));%>" target='_blank'>seguir passos</a>
						</td>
            <td>
							<a href="./resumoTarefa.html?schema=uvis&table=tarefas&qry=select&params=<%out.println(rs.getString("cod_tarefa"));%>," target='_blank'>Resumo da tarefa</a>
						</td>
        </tr><%
            
        }


%>
    </tbody>
</table>
</body>

</html>