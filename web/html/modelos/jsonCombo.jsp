<%@ page 

import="com.wsampaio.jdbc.ClassMap"
import="com.wsampaio.jdbc.ConnDB"
import="com.wsampaio.jdbc.ObjTable"
import="com.wsampaio.jdbc.Field"

import="java.sql.*"

import="java.util.List"
import="java.util.ArrayList"
import="java.util.Collections"

import="org.json.JSONException"
import="org.json.JSONObject"
import="org.json.JSONArray"

contentType="application/json"
pageEncoding="UTF-8"


%><%


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



String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");

String schema = request.getParameter("schema");
String tableName = request.getParameter("table");
String queryName = request.getParameter("qry");
String[] parameters = ( request.getParameter("params") == null )?
	new String[] {}:request.getParameter("params").split(",");

String nomeClasse = "";


Connection conn = new ConnDB().getACCConn(diretorioDB, schema);
String[] className = new ClassMap().getClass(tableName);

ObjTable obj;
Class<?> c = Class.forName("com.wsampaio." + className[1] + "." + className[2]);
obj = (ObjTable) c.newInstance(); 
obj.load(conn);


String query = "";

String[][] lista;


try {

System.out.println(obj.getSQLStatement("consultaComboBox"));


	PreparedStatement stmt = conn.prepareStatement(
		obj.getSQLStatement("consultaComboBox")
	);

	ResultSet rs = stmt.executeQuery();

	int len = 0;

	while (rs.next()){
		len++;
	}
	
	lista = new String[len][2];
	len = 0;

	rs = stmt.executeQuery();

	while (rs.next()){
		lista[len][0] = rs.getString("value");
		lista[len++][1] = rs.getString("option");
	}

	stmt.close();
	rs.close();

} catch(SQLException e){
	throw new RuntimeException(e);
}


























// prepara array principal
// com registros da tabela
JSONArray objRows = new JSONArray();

	
for(int i=0;i<lista.length;i++){


	// objeto da tabela - registro row
	JSONObject objField = new JSONObject();
	objField.put("value", lista[i][0]);
	objField.put("option", lista[i][1]);

	objRows.put(objField);
}

// prepara objeto principal
// nome da tabela no singular (OU NÃO)
JSONObject objJSON = new JSONObject();

// insere registros no objeto principal
objJSON.put(obj.tableName, objRows);

out.print(objJSON.toString());


%>