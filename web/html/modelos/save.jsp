<%-- 
    Document   : save
    Created on : 15 de mai de 2021, 03:18:23
    Author     : wsampaio
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.wsampaio.jdbc.ClassMap"%>
<%@page import="com.wsampaio.jdbc.ConnDB"%>
<%@page import="com.wsampaio.jdbc.Field"%>
<%@page import="com.wsampaio.jdbc.ObjTable"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page 


contentType="text/html" 
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


Connection conn = new ConnDB().getACCConn(diretorioDB, schema);
String[] className = new ClassMap().getClass(tableName);

ObjTable obj;
Class<?> c = Class.forName("com.wsampaio." + className[1] + "." + className[2]);
obj = (ObjTable) c.newInstance(); 
obj.load(conn);



JSONObject jsonObject = new JSONObject(request.getReader().readLine());
Iterator<String> it = jsonObject.keys();


for (Field f : obj.getFields()){
	while(it.hasNext()) {
		String key = it.next();
		obj.setValueOf(key, jsonObject.get(key));
	}
}


obj.save(obj);

request.getRequestDispatcher(
	"/html/modelos/json.jsp" +
		"?schema=" + schema +
		"&table=" + tableName +
		"&qry=select" +
		"&params=" + obj.getValueOf(obj.getPKName()) + ","
).forward(request, response);


%>