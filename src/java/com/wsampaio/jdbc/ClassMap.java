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
package com.wsampaio.jdbc;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * ClassMap registra todos os nomes de tabelas de um banco de dados gravados em
 * um documento csv do usuario e relaciona com uma classe dentro do programa 
 * Os schemas do bando de dados tem relacao com o contexto dos pacotes dentro
 * do programa
 * Os dados do arquivo csv devem seguir o padrao "nomeTabela,schema,nomeClasse"
 * 
 * @author WELL Sampaio
 */
public class ClassMap {
	private String WEBINFPath;
	private List<String[]> classes;

	public ClassMap(){
		this.WEBINFPath = "F:\\NetBeansProjects\\uvis\\web\\WEB-INF\\";
		init();
	}

	public ClassMap(String WEBINFPath){
		this.WEBINFPath = WEBINFPath;
		init();
	}

	/**
	 * Le um arquivo csv com os dados de tabelas de um banco de dados 
	 * e suas respectivas classes dentro do programa e carraga dentro
	 * da lista classes
	 * Retorna um Ero em tempo de execução se a tabela não estiver registrada
	 *
	 * @param tableName nome da tabela a ser pesquisada
	 * @throws RuntimeException em qualquer tipo de erro ocorrido
	 */
	void init() {

		try{
			String line;
			classes = new ArrayList<>();

			BufferedReader br = new BufferedReader(
				new FileReader(WEBINFPath + "tables.csv")
			);

			while ((line = br.readLine()) != null) {
				classes.add(
					new String[] {line.split(",")[0],line.split(",")[1],line.split(",")[2]}
				);
			}
		} catch(Exception e){
			throw new RuntimeException(e);
		}

	}

	/**
	 * Pesquisa uma classe pelo nome da tabela passado como atributo
	 * Retorna um Erro em tempo de execução se a tabela não estiver registrada
	 *
	 * @param tableName - nome da tabela a ser pesquisada
	 * @return uma array no formato [nomeTabela, schema, NomeClasse]
	 * @throws RuntimeException se nao encontrar o nome da tabela
	 */
	public String[] getClass(String tableName){
		for(int i=0; i<classes.size();i++){
			if (classes.get(i)[0].equals(tableName))
				return classes.get(i);
		}

		throw new RuntimeException("TABELA NÃO ENCONTRADA: " + tableName);
	}

	/**
	 * Lista resumida com os schemas de todos classes registradas
	 * 
	 * @param context - schema a ser pesquisado
	 * @return uma lista de arrays no formato [nomeTabela, schema, NomeClasse]
	 *         onde cada objeto pertence ao schema especificado
	 */
	public List<String[]> getClassesByContext(String context){

		List<String[]> l = new ArrayList();

		for(int i=0; i<classes.size();i++){
			if (classes.get(i)[1].equals(context)){
				l.add(classes.get(i));
			}
		}

		return l;
	}

	/**
	 * Lista resumida com os schemas de todos classes registradas
	 * 
	 * @return uma Lista com todos schemas das classes
	 */
	public List<String> getSchemas(){
		List<String> l = new ArrayList<>();
		String schemaName = "";
		
		for(int i=0; i<classes.size();i++){
			if (!classes.get(i)[1].equals(schemaName)){
				l.add(classes.get(i)[1]);
				schemaName = classes.get(i)[1];
			}
		}

		return l;
	}

}

