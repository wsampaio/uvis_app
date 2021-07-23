<%@ page 


import="java.util.List"
import="java.util.ArrayList"

import="org.json.JSONException"
import="org.json.JSONObject"
import="org.json.JSONArray"


import="com.wsampaio.jdbc.ClassMap"

import="com.wsampaio.jdbc.ConnDB"
import="com.wsampaio.jdbc.ObjTable"

import="com.wsampaio.uvis.Tarefa"
import="com.wsampaio.uvis.Passo"
import="com.wsampaio.uvis.Pergunta"

import="java.sql.*"

contentType="application/json"
pageEncoding="UTF-8"

%><%!

/*
contentType="application/json"
contentType="text/html"
*/


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





class Node{
	public JSONObject getPasso(int codPk, Connection conn){
		Passo passo = new Passo();
		passo.load(conn);
		passo.loadPk(codPk);

		Pergunta pergunta = new Pergunta();
		pergunta.load(conn);

		List<JSONObject> perguntaLista = new ArrayList<>();
		String[] s = {String.valueOf(codPk)};
		int[] listaPerguntas = pergunta.getIndexList( "listaPorPasso", s );

		for(int i = 0; i < listaPerguntas.length; i++){
			pergunta.loadPk(listaPerguntas[i]);
			perguntaLista.add(new JSONObject(pergunta.toString()));

			if ((boolean) pergunta.getValueOf("relac_tarefa") == true)
				continue;

			if ( (int) pergunta.getValueOf("cod_proximo_passo") < 1)
				continue;

			perguntaLista.get(i).put(
				"proximo_passo", 
				new Node().getPasso( (int) pergunta.getValueOf("cod_proximo_passo"), conn)
			);

		}

		JSONObject objJSON = new JSONObject(passo.toString());
		//objJSON.put("passo", passo);
		objJSON.put("perguntas", perguntaLista);
		return objJSON;
	}
}


%><%



String diretorioDB = request.getServletContext().getInitParameter("diretorioBD");

String schema = "uvis";
String tableName = "tarefas";
String queryName = "select";
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






int codTarefa = Integer.valueOf(parameters[0]);


Tarefa tarefa = new Tarefa();
tarefa.load(conn);
tarefa.loadPk(codTarefa);

int codPrimeiroPasso = (int) tarefa.getValueOf("cod_primeiro_passo");

List<JSONObject> tarefaLista = new ArrayList<>();

for (int i=0;i<1;i++){
	tarefaLista.add(new JSONObject(tarefa.toString()));
	tarefaLista.get(i).put(
		"primeiro_passo", 
		new Node().getPasso(codPrimeiroPasso, conn)
	);
}

JSONObject objJSON = new JSONObject();
objJSON.put("tarefas", tarefaLista);
out.print(objJSON);

%>