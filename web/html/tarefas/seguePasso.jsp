<%@ page 

import="java.sql.*"

import="com.wsampaio.uvis.Tarefa"
import="com.wsampaio.uvis.Passo"
import="com.wsampaio.uvis.Pergunta"
import="com.wsampaio.jdbc.ConnDB"

contentType="text/html" 
pageEncoding="UTF-8"

%><%

int codPasso = request.getParameter("cod") != null ? 
	Integer.parseInt(request.getParameter("cod")) : 1;


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
<title>seguePasso</title>
		<link rel="stylesheet" href="/html/plugins/picnic.min.css">
		<link href="/html/plugins/select2/css/select2.min.css" rel="stylesheet" />

		<script src="/html/plugins/jquery.min.js"></script>
<style>

	.container {
		padding: 20px;
	}

	table, table div {
		width: 100%;
	}

	.img-pop {
		width: 300px;
	}

	.img-pop, .img-pop-ico {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		text-align: center;
	}
</style>
</head>

<body>

<%


String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");
String schema = "tarefas"; //request.getParameter("schema");

Connection conn = new ConnDB().getACCConn(diretorioDB, schema);

Passo passo = new Passo();
passo.load(conn);
passo.loadPk(codPasso);

Tarefa tarefa = new Tarefa();
tarefa.load(conn);
tarefa.loadPk(1);

Pergunta pergunta = new Pergunta();
pergunta.load(conn);


%>
<div class="container">

<table border='1' class='passoTarefa'>
	<thead>
		<tr>
			<th><h1 class="pageTitle">pageTitle</h1></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<div>
					<h3>
						<a href="seguePasso.jsp?cod=<%
							out.print(tarefa.getValueOf("cod_primeiro_passo"));%>">
							<%out.print(tarefa.getValueOf("tarefa"));%>
						</a>
					</h3>
					<h4><%out.print(passo.getValueOf("titulo"));%></h4><%

						if ( (boolean) passo.getValueOf("passo_final")){

%><br>
					<h3>final</h3><%

						}

%><hr>
					<%
						String txt = (String) passo.getValueOf("texto");
						out.println(txt);%>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class='perguntas'>
<%

String[] s = {String.valueOf(codPasso)};
int[] listaPerguntas = pergunta.getIndexList( "listaPorPasso", s );

					for(int i = 0; i < listaPerguntas.length; i++){
					//while (rs.next()) {
						pergunta.loadPk(listaPerguntas[i]);
%>

					<a class='pergunta' id='<%
						out.print(pergunta.getValueOf("cod_pergunta_passo"));
					%>' href="./seguePasso.jsp?cod=<%
						out.print(pergunta.getValueOf("cod_proximo_passo"));
					%>"<%

						if ( (boolean) pergunta.getValueOf("relac_tarefa")){
							out.print("class='link-externo'");
						}
						%>><%out.print(pergunta.getValueOf("texto"));%></a><br><%
            
        }

%>
				</div>
			</td>
		</tr>

	</tbody>
</table>
<hr>
<div id='edicao'>
<div class='HEAD'>edicao</div>
<div class='BODY'>
	<a href='/html/tarefas/passo.html?schema=uvis&table=passos&qry=select&params=<%out.print(codPasso);%>,' target='_blank'>editar passo</a>
	<div class='perguntas edicao'></div>
</div>
<div class='FOOT'></div>
</div>

</div>

<script>





//json.jsp?schema=uvis&table=passos&qry=select&params=1,









$("#edicao .BODY").css("display", "none");

$("#edicao .HEAD").on("click", function(){
	if ($("#edicao .BODY").css("display") == "none"){
		$("#edicao .BODY").css("display", "block");
		$(".perguntas.edicao").html($(".perguntas").html());
		$("#edicao a").on("click", function(){
			event.preventDefault();
			if ($(this).parent(".BODY").length > 0){
				window.open($(this).attr("href"));
			} else {
				window.open(
					"/html/tarefas/pergunta.html" +
						"?schema=uvis" +
						"&table=perguntas" +
						"&qry=select&params=" + $(this).attr("id") + ","
				);
			}
		});
	} else {
		$("#edicao .BODY").css("display", "none");
		$(".perguntas.edicao").html();
	}
});

$("a").on("click", function(){
	//event.preventDefault();
});


//pageTitle



$(document).ready(function(){
	$(".link-externo").append("&nbsp;<img src='/html/images/new_window.png' style='height: 12px;'>");
	$(".link-externo").attr("target", "_blank");
});
</script>

</body>

</html>