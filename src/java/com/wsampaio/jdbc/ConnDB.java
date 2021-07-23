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

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author wsampaio
 */
public class ConnDB {

	Connection conn;
	String schema;
	String DBFolder;

	public void init(){
		//Connection conn = DriverManager.getConnection("jdbc:sqlite:DB/tarefas.db");
	}

	public Connection getConn(String DBFolder, String schema){
		this.schema = schema;
		this.DBFolder = DBFolder;
		return getConn();
	}

	private Connection getConn(){
		try {
			Class.forName("org.sqlite.JDBC");

			return DriverManager.getConnection(
					"jdbc:sqlite:" + DBFolder + schema + ".db"
			);
		} catch (Exception e){
			throw new RuntimeException(e);
		}
	}

	public Connection getACCConn(String DBFolder, String schema){
		try {
			Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");

			schema = "uvis";

			return DriverManager.getConnection(
				"jdbc:ucanaccess://" + DBFolder + schema + ".mdb"
			);

		} catch (Exception e){
			throw new RuntimeException(e);
		}
		
		
		
	}


}