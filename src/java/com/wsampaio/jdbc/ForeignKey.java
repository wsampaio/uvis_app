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

/**
 *
 * @author d729584
 */
public class ForeignKey {
	private String pkTable;
	private String pkField;
	private ObjTable objTable;

	public ForeignKey(String pkTable, String pkField){
		this.pkTable = pkTable;
		this.pkField = pkField;
	}

	public String getPkTable (){
		return pkTable;
	}

	public String getPkField (){
		return pkField;
	}

	public ObjTable getObjTable (){
		return objTable;
	}

	public void setObjTable (int cod, Connection conn){


		try{
			String[] className = new ClassMap().getClass(pkTable);
			Class<?> c = Class.forName(
				"com.wsampaio." + className[1] + "." + className[2]
			);

			ObjTable obj = (ObjTable) c.newInstance(); 
			obj.load(conn);
			obj.loadPk(cod);

			objTable = obj;

		} catch (Exception e){
			throw new RuntimeException(e);
		}
	}


	@Override
	public String toString(){
		return "" +
			"{" +
				"\"pkTable\":\"" + pkTable + "\"," +
				"\"pkField\":\"" + pkField + "\"," +
				"\"obj\":" + objTable + "," +
			"}";
	}


}
