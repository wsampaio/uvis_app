<%@ page 

import="java.io.File"


import="com.healthmarketscience.jackcess.Database"
import="com.healthmarketscience.jackcess.Database"
import="com.healthmarketscience.jackcess.DatabaseBuilder"
import="com.healthmarketscience.jackcess.query.Query"
import="com.healthmarketscience.jackcess.Table"
import="com.healthmarketscience.jackcess.Row"
import="java.sql.*"

import="java.util.List"
import="java.util.ArrayList"

import="com.wsampaio.jdbc.ConnDB"

contentType="text/html" 
pageEncoding="UTF-8"

%><%!

/*
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
*/


class Campo{
  public String nome = "";
  public String tipo = "";
  
  public Campo(String nome, String tipo){
	this.nome = nome;
	this.tipo = tipo;
  }

}

%><%

List<Campo> listaCampos = new ArrayList<>();

listaCampos.add(new Campo("cod_uvis", "number"));
listaCampos.add(new Campo("uvis", "text"));
listaCampos.add(new Campo("regiao", "text"));
listaCampos.add(new Campo("ponto_sei", "text"));
listaCampos.add(new Campo("email", "text"));
listaCampos.add(new Campo("endereco", "text"));
listaCampos.add(new Campo("compl", "text"));
listaCampos.add(new Campo("bairro", "text"));
listaCampos.add(new Campo("cep", "text"));
listaCampos.add(new Campo("telefone", "text"));


int cod_uvis = request.getParameter("cod") != null ?
  Integer.parseInt(request.getParameter("cod")) :
  0;





%><!DOCTYPE html>
<html>
<head>
<title>Title of the document</title>
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

String schema = "uvis";
String tableName = "tabela_uvis";
String queryName = "";



String[] parameters = ( request.getParameter("params") == null )?
	new String[] {}:request.getParameter("params").split(",");




String nomeClasse = "";


Connection conn = new ConnDB().getACCConn(diretorioDB, schema);
Statement s = conn.createStatement();

ResultSet rs = s.executeQuery(
    "SELECT * " +
    "FROM tabela_uvis " +
    "WHERE cod_uvis = " + String.valueOf(cod_uvis) + ";"
);


%>

  <table><%
	
	String inputOut = "";
	
	
	while (rs.next()) {
	
	
	
	
	  for(Campo campo : listaCampos){
%>
	<tr>
	  <th>
		<span class="title"><%out.println(campo.nome);%></span>
	  </th>
	  <td>
		<span class="lbl"><%out.println(rs.getString(campo.nome));%></span>
		<span class="input"><%
		  
		  inputOut = "";
/*
		  switch (campo.tipo){
			case "":
			  break;
			default:
			  inputOut = "<input type='text' name='nome' value='" + 
				rs.getString(campo.nome) + 
				"'>";
			  break;
		  }
*/
%>
		  <%out.println(inputOut);%>
		</span>
	  </td>
	</tr><%

	  }
	}
%>
  </table>


















	<script src="./jquery.min.js"></script>
	<script>
	  //
	  $(".input").css("display", "none");
	</script>
</body>

</html>