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

/**
 *
 * @author WELL Sampaio
 */
public class Field{

  public String fieldName;
  public String fieldType;
  public int fieldIndex;
  public Object fieldValue;
  public boolean pkField;
  public ForeignKey fKey;

	public Field(String fieldName, String fieldType){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
	}

	public Field(String fieldName, String fieldType, boolean pkField){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
		this.pkField = pkField;
	}

  public Field(String fieldName, String fieldType, int fieldIndex){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
		this.fieldIndex = fieldIndex;
		this.pkField = false;
  }

  public Field(String fieldName, 
	             String fieldType, 
							 int fieldIndex, 
							 boolean pkField
	){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
		this.fieldIndex = fieldIndex;
		this.pkField = pkField;
  }

  public Field(String fieldName, 
	             String fieldType, 
							 int fieldIndex, 
							 ForeignKey fKey
	){
		this.fieldName = fieldName;
		this.fieldType = fieldType;
		this.fieldIndex = fieldIndex;
		this.fKey = fKey;
  }

	public int getFieldIndex(){
		return fieldIndex;
	}

	void setFKey(ForeignKey fKey){
		this.fKey = fKey;
	}

	public ForeignKey getFKey(){
		return fKey;
	}




	@Override
	public String toString(){
		String saida = "" +
			"{" +
				"\"fieldIndex\":" + fieldIndex + "," +
				"\"fieldName\":\"" + fieldName + "\"," +
				"\"pkField\":" + pkField + "," +
				"\"fieldType\":\"" + fieldType + "\",";
		
		if (fieldValue == null){
			saida += "\"fieldValue\":\"" + "\",";
		} else {
			saida += "\"fieldValue\":\"" + 
						fieldValue.toString()
							.replace("\\", "\\\\")
							.replace("\"", "\\\"")
							.replace("\'", "\\'")
							.replace("\n", "\\n")
							.replace("\r", "\\r")
							.replace("\t", "\\t")
							.replace("", "") +
						"\",";
		}
				
		saida += 
				"\"fKey\":" + (fKey==null?null:fKey.toString()) + "" +
			"}";

		//System.out.println(saida);

		return saida;
		
	}


}

