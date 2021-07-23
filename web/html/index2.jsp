<%@ page 

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
<html>
  <head>
    <title>Intranet UVIS</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>

		<div class="conteudo">

			<h2>Links uteis</h2>
			<ul>
				<li>
					<a href='http://outlook.com/owa/saude.prefeitura.sp.gov.br' target='_blank'>
						E-mail institucional - outlook.com
				</li>
				<li>
					<a href='/html/tarefas/resumoTarefa.html?schema=uvis&table=tarefas&qry=select&params=7,' target='_blank'>
						Como configurar primeiro acesso ao PC</a>
				</li>
				<li>
					<a href='/html/tarefas/resumoTarefa.html?schema=uvis&table=tarefas&qry=select&params=2,' target='_blank'>
						Como acessar servidor de arquivos</a>
				</li>
			</ul>


			<h2>Praça de atendimento</h2>
			<ul>
				<li>
					<a href='https://outlook.office.com/mail/atendimentouvissmateus@PREFEITURA.SP.GOV.BR' target='_blank'>
						E-mail da praça</a>
				</li>

				<li>
					<a href="/html/cnae/cnaeLista.jsp" target="_blank">
						Lista dos CNAES - Portaria 2215/16</a>
				</li>
				<li>
					<a href="https://www.prefeitura.sp.gov.br/cidade/secretarias/saude/vigilancia_em_saude/index.php?p=226958" target="_blank">
						site da prefeitura - Licença Sanitária - CMVS</a>
				</li>
				<li>
					<a href="http://www.prefeitura.sp.gov.br/cidade/secretarias/upload/chamadas/anexo_x_-_alteracao_renovacao_licenca_alterado_1482773665.pdf" target="_blank">
						site da prefeitura - sobre alterações de dados cadastrais</a>
				</li>
				<li>
					<a href="/html/tarefas/resumoTarefa.html?schema=uvis&table=tarefas&qry=select&params=4," target="_blank">
						POP - Atendimento da Praça</a>
				</li>
				<li>
					<a href="/html/uvis/uvisLista.jsp" target="_blank">
						Lista das UVIS</a>
				</li>
			</ul>


			<div id="dev">
				<div class="HEAD">links desenvolvimento</div>
				<div class="BODY">

					<hr>

					<a href='./modelos' target='_blank'>modelos</a>
					<hr>
					<a href='/tomcat' target='_blank'>TOMCAT MANAGER</a>
					<hr>

					<a href="/html/tarefas/tarefaLista.jsp" target="_blank">tarefaLista</a><br>
					<a href="cnaeLista.jsp" target="_blank">cnaeLista</a><br>
					<a href="uvisLista.jsp" target="_blank">uvisLista</a><br>
					<a href="passoLista.jsp" target="_blank">passoLista</a><br>
					<a href="perguntaLista.jsp" target="_blank">perguntaLista</a><br>
					<hr>

					<a href="popTarefas.jsp" target="_blank">popTarefas</a><br>
					<a href="resumoTarefa.jsp" target="_blank">resumoTarefa</a><br>
					<a href="./editor" target="_blank">editor de texto</a><br>
					<hr>

					<a href="https://1drv.ms/u/s!AgXL3GiGK9Cjg8Y9UWd4XYpl06j_8g?e=YhI64W" target="_blank">
						POPs - UVIS - Microsoft OneNote Online</a><br>

					<a>tomcat Integrated Windows Authentication</a>

				</div>
			</div>




		</div>
  </body>
</html>