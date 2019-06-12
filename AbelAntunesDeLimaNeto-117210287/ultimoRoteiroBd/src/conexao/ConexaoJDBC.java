package conexao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexaoJDBC {
	private static String driver = "org.postgresql.Driver";
	
	private static String usuarioBD = "nfelkiiz"; // Alterar (User do Elephant)
	private static String senhaBD = "Za8qoYbbKTx7HBMQ4o46pFTtelL3S6Yr"; // Alterar (Senha do Elephant)
	 

	  public static Connection criarConexao() {
	    
		final String urlConexao = "jdbc:postgresql://raja.db.elephantsql.com:5432/"  + usuarioBD;	
	            Connection conexao = null;

		try {
	 	 
	  	Class.forName(driver);
	  	conexao = DriverManager.getConnection(urlConexao, usuarioBD, senhaBD);
	  	conexao.setAutoCommit(false);
	 	 
	  	System.out.println("Conexao com o banco aberta com sucesso!!!");

		} catch (Exception e) {
	 	 
	  	System.err.println(e.getClass().getName() + ": " + e.getMessage());
	  	System.exit(0);
	 	 
		}
	    
		return conexao;
	    
	  }

}


