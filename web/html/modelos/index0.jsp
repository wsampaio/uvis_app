<%-- 
    Document   : index0.jsp
    Created on : 15 de mai de 2021, 03:18:23
    Author     : wsampaio
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.wsampaio.jdbc.ClassMap"%>
<%@page import="com.wsampaio.jdbc.ConnDB"%>
<%@page import="com.wsampaio.jdbc.Field"%>
<%@page import="com.wsampaio.jdbc.ObjTable"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONObject"%>
<%@page 


contentType="text/html" 
pageEncoding="UTF-8"

%><%

response.flushBuffer();

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
<html lang="pt-br">
	<head>
		<meta charset="UTF-8">
		<meta name = "viewport" 
			content = "width=device-width,initial-scale=1,shrink-to-fit=no">
		<link rel="stylesheet" href="/html/plugins/picnic.min.css">

		<script src="/html/plugins/jquery.min.js"></script>

		<style>
			* {
				font-family: Courier New, monospace;
			}
		</style>

	</head>
	<body>
		<div class='container'>
			<div class='HEAD'></div>
			<div class='BODY'></div>
			<div class='FOOTER'></div>
		</div>
<%


%>
		<script>
			$(function(){
				carregaLista();
			});

			// variaveis


			let tabelas = {<%

ClassMap classMap = new ClassMap();

String schemaStr = "";
String tableStr = "";

for(String schema : classMap.getSchemas()){
	tableStr = "";
	for(String[] classes : classMap.getClassesByContext(schema))
		tableStr += ",\"" + classes[0] + "\"";

	if (tableStr.length() < 1)
		tableStr = " ";

	schemaStr = ", \"" + schema + "\":[" + tableStr.substring(1) + "]";
}

if (schemaStr.length() < 2)
	schemaStr = "  ";

out.print(schemaStr.substring(2));

%>};


			// metodos

			let carregaLista = function(){
				var tabelasLength = Object.keys(tabelas).length;

				for (i=0;i<tabelasLength;i++){
					var schema = Object.keys(tabelas)[i];

					$(".container .BODY").append(
						"<ul class='schema' id='" + schema + "'>" +
							"<li class='schema-name'>" +
								schema + 
							"</li>" +
							"<ol class='table-names'></ol>" +
						"</ul>"
					);

					for(j=0;j<tabelas[schema].length;j++){
						$("#" + schema + " .table-names").append(
							"<li><a class='link-lista' " +
								"href='" +
									"?schema=" + schema + 
									"&table=" + tabelas[schema][j] + 
									"&qry=" + "getIndexList" + 
								"'"+
							">" + 
								tabelas[schema][j] + 
							"</a></li>"
						);
					}
				}

				$(".link-lista").on("click", function(){
					event.preventDefault();
					window.open("./list.html" + $(this).attr("href"));
				});
			};


		</script>
	</body>
<html>
