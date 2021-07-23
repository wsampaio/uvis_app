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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


/**
 *
 * @author WELL Sampaio
 */
public abstract class ObjTable{
	public String schema;
	public String tableName;
	public String pkName;
	public Field[] objFields = new Field[0];
	public SqlStatement[] sqlStatements = new SqlStatement[0];
	public Connection conn;
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
		"yyyy-MM-dd HH:mm:ss"
	);

	public Field[] getFields(){
		return objFields;
	}

	public abstract void setAttributes();

	public void load(Connection conn){
		setConnection(conn);
		setDefaultSQLStatement();
		loadFields();
	}

	public void setConnection(Connection conn){
		this.conn = conn;
	}

	public int[] getIndexList(String queryName, String[] ... parameters){
		if (objFields.length < 1) loadFields();

		int[] index = new int[0];

		try {

			PreparedStatement stmt = conn.prepareStatement(
				"select count(*) from (" + getSQLStatement(queryName) + ")"
			);

			for (int i=0;i<parameters[0].length;i++)
				stmt.setString(i+1, parameters[0][i]);

			ResultSet rs = stmt.executeQuery();

			int size = 0;

			while (rs.next())
				size = rs.getInt(1);

			index = new int[size];

			stmt = conn.prepareStatement(getSQLStatement(queryName));

			for (int i=0;i<parameters[0].length;i++)
				stmt.setString(i+1, parameters[0][i]);

			rs = stmt.executeQuery();

			int i = 0;
			while(rs.next()){
				index[i] = rs.getInt(1);
				i++;
			}

			stmt.close();
			rs.close();

		} catch(SQLException e){
			throw new RuntimeException(e);
		}

		return index;
	}

	public void setDefaultSQLStatement(){
		setSQLStatement(
			"select", 
			"index", 
			"SELECT " + 
					//"* " +
					pkName + " " +
				"FROM " +
					tableName + " " +
				"WHERE " +
					pkName + " = ?" +
			""
		);

		setSQLStatement(
			"getIndexList", 
			"index", 
			"SELECT " + 
					//"* " +
					pkName + " " +
				"FROM " +
					tableName + " " +
				"ORDER BY " +
					pkName + //" DESC LIMIT 3" +
			""
		);

		setSQLStatement(
			"getLast", 
			"index", 
			"SELECT " + 
					//"* " +
					pkName + " " +
				"FROM " +
					tableName + " " +
				"ORDER BY " +
					pkName + " DESC LIMIT 1" +
			""
		);
	}

	public void setSQLStatement(String queryName, 
															String statementType, 
															String queryStatement
	){
		int index = sqlStatements.length;
		SqlStatement[] tmpSql = new SqlStatement[index + 1];

		for(int i = 0; i < index; i++){
			tmpSql[i] = sqlStatements[i];
		}

		tmpSql[index] = new SqlStatement(queryName, statementType, queryStatement);

		sqlStatements = tmpSql;
	}

	public String getSQLStatement(String sqlName, String[] ... parameters){
		String s = "";

		for (int i = 0; i < sqlStatements.length; i++){
			if (sqlStatements[i].queryName.equals(sqlName)){
				s = sqlStatements[i].queryStatement;
			}
		}

		if (s == ""){
			throw new RuntimeException(
				"A CONSULTA NÃO EXISTE: " +
				"\"" + sqlName + "\"" + " em " +
				this.getClass().getName()
			);
		}
			

		return s;
	}

	private void loadFields (){
		try {

			PreparedStatement stmt = conn.
				prepareStatement("select * from " + 
					tableName + " LIMIT 1");

			ResultSet rs = stmt.executeQuery();
			int columnCount = rs.getMetaData().getColumnCount();

			objFields = new Field[columnCount];

//conn.getMetaData()

			for(int i = 0;i<columnCount;i++){
				String columnName = rs.getMetaData().getColumnName(i+1);

				if ( 	columnName.equals(pkName) ){
					objFields[i] = new Field(
						columnName, 
						rs.getMetaData().getColumnTypeName(i+1), 
						rs.findColumn(columnName), 
						true
					);
				} else {
					//String fi
					objFields[i] = new Field(
						columnName, 
						rs.getMetaData().getColumnTypeName(i+1),
						rs.findColumn(columnName)
					);
				}

				// DEFINE O VALOR NULL
				switch (objFields[i].fieldType){
					case "INTEGER":
						objFields[i].fieldValue = (int) 0;
						break;
					case "VARCHAR":
						if (rs.getMetaData().getColumnDisplaySize(i+1)>300){
							objFields[i].fieldType = "MEMO";
							objFields[i].fieldValue = (String) new String("");
						} else {
							objFields[i].fieldValue = (String) new String("");
						}
					case "TEXT":
					case "BIGTEXT":
						objFields[i].fieldValue = (String) new String("");
						break;
					case "LOCALDATETIME":
						objFields[i].fieldValue = (LocalDateTime) LocalDateTime.parse("0000-01-01T00:00");
						break;
					case "BOOLEAN":
						objFields[i].fieldValue = (boolean) false;
						break;
					default:
						objFields[i].fieldValue = (String) "INDEFINIDO: " + objFields[i].fieldType;
						break;
				}
			}

			// adiciona as chaves estrangeiras
			ResultSet rsFK = conn.getMetaData().getImportedKeys(null, null, tableName);

			while (rsFK.next()){
				for(int i = 0;i<columnCount;i++){
					if (objFields[i].fieldName.equals(rsFK.getString(8))){
						objFields[i].setFKey(new ForeignKey(rsFK.getString(3), rsFK.getString(4)));
					}
				}
			}

			stmt.close();
			rs.close();
			rsFK.close();



		} catch(SQLException e){
			throw new RuntimeException(e);
		}
	}

	public void loadPk(int codPk){
		if (objFields.length < 1) loadFields();

		try {

			PreparedStatement stmt = conn.prepareStatement(
				"select * from " + 
				tableName + " WHERE " + pkName + " = ?"
			);

			stmt.setInt(1, codPk);
			ResultSet rs = stmt.executeQuery();



			while (rs.next()){
				for(int i = 0;i<objFields.length;i++){
					switch (objFields[i].fieldType){
						case "INTEGER":
							objFields[i].fieldValue = (int) rs.getInt(objFields[i].fieldName);

							if (objFields[i].fKey != null)
								objFields[i].fKey.setObjTable(
									rs.getInt(objFields[i].fieldName), conn
								);

							break;
						case "VARCHAR":
						case "TEXT":
						case "BIGTEXT":
						case "MEMO":
							objFields[i].fieldValue = (String) rs.getString(objFields[i].fieldName);
							break;
						case "TIMESTAMP":
							if(rs.getString(objFields[i].fieldName) != null){
								objFields[i].fieldValue = (LocalDateTime) LocalDateTime.parse(
									rs.getString(objFields[i].fieldName).substring(0, 19),
									formatter
								);
							}
							break;
						case "LOCALDATETIME":
							objFields[i].fieldValue = (LocalDateTime) LocalDateTime.parse(
								rs.getString(objFields[i].fieldName)
							);
							break;
						case "BOOLEAN":
							objFields[i].fieldValue = (boolean) rs.getBoolean(objFields[i].fieldName);
							break;
						default:
							objFields[i].fieldValue = (String) "INDEFINIDO: " + objFields[i].fieldType;
							break;
					}
				}
			}

			stmt.close();
			rs.close();

		} catch(SQLException e){
			throw new RuntimeException(e);
		}
	}

	public String getPKName(){
		return pkName;
	}

	public String getTableName(){
		return tableName;
	}

	public Object getValueOf(String field){
		if (objFields.length < 1) loadFields();

		for(int i=0;i<objFields.length;i++){
			if (objFields[i].fieldName.equals(field)){
				/* TODO - CAST DE SAIDA */
				return objFields[i].fieldValue;
			}
		}
		return null;
	}

	public void setValueOf(String field, Object value){
		if (objFields.length < 1) loadFields();

		for(int i=0;i<objFields.length;i++){
			if (objFields[i].fieldName.equals(field)){

//System.out.println( objFields[i].fieldType + " - " + String.valueOf(value) );



				switch (objFields[i].fieldType){
					case "INTEGER":
						objFields[i].fieldValue = Integer.parseInt(String.valueOf(value));
						break;
					case "VARCHAR":
					case "TEXT":
					case "BIGTEXT":
					case "MEMO":
						objFields[i].fieldValue = String.valueOf(value);
						break;
					case "TIMESTAMP":
					case "LOCALDATETIME":
						objFields[i].fieldValue = (LocalDateTime) LocalDateTime.parse(String.valueOf(value));
						break;
					case "BOOLEAN":
						objFields[i].fieldValue = Boolean.parseBoolean(String.valueOf(value));
						break;
					default:
						objFields[i].fieldValue = (String) "INDEFINIDO: " + objFields[i].fieldType;
						break;
				}
			}
		}
	}

	public void save(ObjTable obj){

		String sql = "", sql1 = "", sql2 = "";
		boolean update = ((int) obj.getValueOf(obj.pkName) > 0)?true:false;

		// cria o codigo SQL
		for (int i = 1;i<obj.objFields.length;i++){
			if (update){
				sql1 += ", " + obj.objFields[i].fieldName + " = ?";
			} else {
				sql1 += ", " + obj.objFields[i].fieldName;
				sql2 += ", ?";
			}
		}

		if (update){
			sql += "UPDATE " + obj.tableName + " SET " + 
				sql1.substring(2) + " WHERE " + obj.pkName + " = ?;";
		} else {
			sql += "INSERT INTO " + obj.tableName + " (" + 
				sql1.substring(2) + ") VALUES (" + 
					sql2.substring(2) + ")";
		}

		try {

			PreparedStatement stmt = conn.prepareStatement(sql);

			for(int i = 1;i<obj.objFields.length;i++){
				switch (obj.objFields[i].fieldType){
					case "INTEGER":
						stmt.setInt(i, (int) obj.objFields[i].fieldValue);
						break;
					case "REAL":
						stmt.setDouble(i, (double) obj.objFields[i].fieldValue);
						break;
					case "TEXT":
					case "BIGTEXT":
					case "TIMESTAMP":
						LocalDateTime dt = (LocalDateTime) obj.objFields[i].fieldValue;
						stmt.setString(i, dt.format(formatter));
						break;
					case "LOCALDATETIME":
						stmt.setString(i, (String) obj.objFields[i].fieldValue.toString());
						break;
					case "BOOLEAN":
						stmt.setBoolean(i, (boolean) obj.objFields[i].fieldValue);
						break;
					default:
						stmt.setString(i, (String) obj.objFields[i].fieldValue);
						break;
				}
			}

			if (update){
				stmt.setInt(obj.objFields.length, (int) obj.objFields[0].fieldValue);
			}

			int updated = stmt.executeUpdate();
			//ResultSet generatedKeysResultSet = ps.getGeneratedKeys();

			ResultSet rs = stmt.getGeneratedKeys();
			//rs.first();
			
			int codPk = (int) obj.objFields[0].fieldValue;
			
			if (!update){
				while(rs.next())
					codPk = rs.getInt(1);
			}

			obj.loadPk(codPk);

			stmt.close();
			rs.close();

		} catch(SQLException e){
			throw new RuntimeException(e);
		}

	}

	@Override
	public String toString(){
		if (objFields.length < 1) loadFields();
		String saida = "";
		
		//for(Field f in objFields){
		for(int i = 0; i < objFields.length; i++){

			Object formatValue = null;

			switch(objFields[i].fieldType){
				case "MEMO":
				case "VARCHAR":
					String str = "";
					str = (String) objFields[i].fieldValue;
					if (str != null) {
						str = str
							.replace("\\", "\\\\")
							.replace("\"", "\\\"")
							.replace("\'", "\\'")
							.replace("\n", "\\n")
							.replace("\r", "\\r")
							.replace("\t", "\\t")
							.replace("", "");
					}

					formatValue = str;

					//System.out.println("str : " + str);
					break;
				default:
					formatValue = objFields[i].fieldValue;
					break;
			}

			saida += ",\"" + objFields[i].fieldName + "\":{" + 
				"\"fieldName\":\"" + objFields[i].fieldName + "\"," +
				"\"fieldType\":\"" + objFields[i].fieldType + "\"," +
				"\"fieldValue\":\"" + formatValue + "\"," +
				"\"pkField\":\"" + objFields[i].pkField + "\"" +
				"}";
		}
		
		//saida = getClass().getName() + " [" + saida.substring(1) + "]";
		//saida = tableName + ": [" + saida.substring(1) + "]";
		
		saida = "{" + saida.substring(1) + "}";

		//System.out.println("saida : " + saida);

		return saida;
	}

}
