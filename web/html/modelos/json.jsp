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


int[] lista;

if(queryName != null){
	lista = obj.getIndexList(queryName, parameters);
} else {
	lista = obj.getIndexList("getLast");
}


// pegar chaves extrangeiras





/*
jackcess, 
hsqldb,
commons-logging and 
commons-lang
*/





/*


BUSCA CHAVES ESTRANGEIRAS

String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");


String schema = request.getParameter("schema");
String tableName = request.getParameter("table");
String queryName = request.getParameter("qry");
String[] parameters = ( request.getParameter("params") == null )?
new String[] {}:request.getParameter("params").split(",");


Connection conn = new ConnDB().getACCConn(diretorioDB, schema);



java.sql.ResultSet rs = conn.getMetaData().getImportedKeys(null, null, "modelos");

while (rs.next()){
	for (int i = 1; i <= 14; i++){
		out.println(i + ": " + rs.getMetaData().getColumnName(i));
		//out.println(i + ": " + rs.getString(i));
	}
}


//rs.getString(3) // PKTABLE_NAME
//rs.getString(4) // PKCOLUMN_NAME


//rs.getString(6) // FKTABLE_SCHEM


// 01: PKTABLE_CAT
// 02: PKTABLE_SCHEM
// 03: TABLE_NAME
// 04: COLUMN_NAME

// 05: FKTABLE_CAT
// 06: FKTABLE_SCHEM
// 07: TABLE_NAME
// 08: COLUMN_NAME

// 09: KEY_SEQ
// 10: UPDATE_RULE
// 11: DELETE_RULE
// 12: FK_NAME
// 13: PK_NAME
// 14: DEFERRABILITY









*/
















// prepara array principal
// com registros da tabela
JSONArray objRows = new JSONArray();

for(int i : lista){

	obj.loadPk(i);

	// objeto da tabela - registro row
	JSONObject objField = new JSONObject();

	// passa por cada campo do registro
	for(Field f : obj.objFields){

		// pega campos Field do registro row
		JSONObject field = new JSONObject(f.toString());



// insere objFK
/*

if 
08: COLUMN_NAME = fieldName

{
// 02: PKTABLE_SCHEM
// 03: TABLE_NAME

}


*/
// field.put("fk", "00");



		// insere campos Field no registro row
		objField.put(f.fieldName, field);
	}

	// insere registro row no arr da tabela
	objRows.put(objField);

}

// prepara objeto principal
// nome da tabela no singular (OU NÃO)
JSONObject objJSON = new JSONObject();

// insere registros no objeto principal
objJSON.put(obj.tableName, objRows);

out.print(
	objJSON.toString()
		.replace("{", "\n{")
		.replace(",\"", ",\n\"")
		.replace("{\"", "{\n\"")
		.replace("\"}", "\"\n}")
);


%>