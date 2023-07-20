package br.ufsm.csi.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConectaBD {
    private static final String DRIVER = "org.postgresql.Driver";
    private static final String URL = "jdbc:postgresql://127.00.1:5432/aplicativo";
    private static final String USER = "postgres";
    private static final String PASS = "1234";

    public Connection getConexao() {
        Connection conn = null;
        try {
            Class.forName(this.DRIVER);
            conn = DriverManager.getConnection(this.URL, this.USER, this.PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
