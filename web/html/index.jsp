<%@ page 

contentType="text/html" 
pageEncoding="UTF-8"

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
		<title>INTRANET - UVIS São Mateus</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="/html/plugins/picnic.min.css">

		<script src='./plugins/jquery.min.js'></script>

		<style>

			body, html {
				height: 100%;
			}

			* {
				box-sizing: border-box;
			}

			.bg-image {
				/* The image used */
				background-image: url("/html/images/under_construction_bgn.jpg");

				/* Add the blur effect */
				filter: blur(8px);
				-webkit-filter: blur(8px);

				/* Full height */
				height: 100%;

				/* Center and scale the image nicely */
				background-position: center;
				background-repeat: no-repeat;
				background-size: cover;
			}

			/* Position text in the middle of the page/image */
			.bg-text {
				background-color: rgb(0,0,0); /* Fallback color */
				background-color: rgba(0,0,0, 0.4); /* Black w/opacity/see-through */
				color: white;
				font-weight: bold;
				border: 3px solid #f1f1f1;
				position: absolute;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				z-index: 2;
				width: 80%;
				padding: 20px;
				text-align: center;
			}

			p, h1, h3, img {
				text-align: center;
			}

			img {
				display: block;
				margin-left: auto;
				margin-right: auto;
				height: 80px;
			}

			.links {
				display: inline-block;
			}

		</style>

	</head>
	<body>
		<div class="bg-image"></div>
		<div class="bg-text">
			<h1>INTRANET - UVIS São Mateus</h1>
			<p>Página em construção
			<img src='/html/images/under_construction.png'></p>
			<h6>Clique <a href='/html/index.html'>aqui</a> para entrar assim mesmo</h6>
		</div>

		<script>

			var contador = 0;
			var pass = 'COVISA';

			$(document).on("keydown", function(){
				if (pass[contador] = String.fromCharCode(event.keyCode)){
					contador++;
				} else {
					contador=0;
				}

				if (contador == pass.length)
					$(".links").toggle();
			});

		</script>

	</body>
</html>