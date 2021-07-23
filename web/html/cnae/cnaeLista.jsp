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
    <title>Lista dos CNAEs</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/html/plugins/picnic.min.css">

		<script src="/html/plugins/jquery.min.js"></script>

		<style>


			.container .HEAD {
				position: fixed;
				top: 0;
				left: 0;
				background-color: rgba(0, 0, 0, 0.5);
				width: 100%;
				height: 50px;
			}

			.container .FOOT {
				position: fixed;
				bottom: 0;
				left: 0;
				background-color: rgba(0, 0, 0, 0.5);
				width: 100%;
				height: 49px;
			}

			.container .BODY {
				padding-top: 50px;
				padding-bottom: 50px;
			}



			.container .HEAD .demo{
				background-color: rgba(0, 0, 0, 0.0);
			}



			table thead th {
				position: -webkit-sticky; /* this is for all Safari (Desktop & iOS), not for Chrome*/
				position: sticky;
				top: 50px;
				z-index: 0; /* any positive value, layer order is global*/
			}

			.col2 {
				display:none;
			}
		</style>
	</head>
	<body>

<%


String dbFile = request.getServletContext().getInitParameter("diretorioBD");
String schema = "uvis";

String user="", password="";

Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");

Connection conn=DriverManager.getConnection(
	"jdbc:ucanaccess://" + dbFile + "/" + schema + ".mdb"
);
Statement s = conn.createStatement();

ResultSet rs = s.executeQuery(
    "SELECT * " +
    "FROM cnaes " +
    "ORDER BY cnae;"
);


%>

		<div class="container" id="">
			<div class="HEAD">
					<nav class="demo">
						<div class="menu">
							<input placeholder="Pesquisar CNAE" id="pesquisaCNAE" onkeyup="pesquisaCNAE()" />
						</div>
					</nav>
			</div>
			<div class="BODY">




				<table border='1' id="tabelaCNAE">
					<thead>
						<tr>
							<th class="col0" width="150">CNAE</th>
	            <th class="col1">descricao</th>
	            <th class="col2">observacoes</th>
						</tr>
					</thead>
					<tbody><%

					while (rs.next()) {
%>
						<tr>
							<td class="col0">
								<a href="./cnae.html?schema=uvis&table=cnaes&qry=select&params=<%
									out.println(rs.getString("cod_cnae"));
								%>," target="_blank">
									<%out.println(rs.getString("CNAE"));%>
								</a>
								<span style="display:none;"><%
									out.println(
										rs.getString("CNAE")
											.replace("-", "")
											.replace("/", "")
									);
								%></span>
							</td>
							<td class="col1"><%out.println(rs.getString("descricao"));%></td>
							<td class="col2"><%out.println(rs.getString("observacoes"));%></td>
						</tr><%

					}
%>
					</tbody>
				</table>
			</div>
					<div class="FOOT"></div>
		</div>


		<script>

			$(function(){
				//
				$("#pesquisaCNAE").focus();
			});



			//fecharBtn
			$(".container .FOOT").append("<button id=fecharBtn>Fechar</button>");

			let fecharBtn = document.getElementById("fecharBtn");

			fecharBtn.addEventListener("click", function(){
				self.close();
			}, false);


			// filtra tabela pelocampo de pesquisa
			function pesquisaCNAE() {
				var input, filter, table, tr, td, i, txtValue;
				input = document.getElementById("pesquisaCNAE");
				filter = input.value.toUpperCase();
				table = document.getElementById("tabelaCNAE");
				tr = table.getElementsByTagName("tr");
				for (i = 0; i < tr.length; i++) {
					if (tr[i]) {
						txtValue = tr[i].textContent || tr[i].innerText;
						if (txtValue.toUpperCase().indexOf(filter) > -1) {
							tr[i].style.display = "";
						} else {
							tr[i].style.display = "none";
						}
					}       
				}
			}



		</script>

	</body>
</html>
