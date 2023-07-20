package br.ufsm.csi.dao;

import br.ufsm.csi.model.Usuario;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.sql.*;

public class UsuarioDao {
    //declaração das variáveis
    private String sql;
    private Statement statement; //usado para trazer informações do sql
    private ResultSet resultSet;
    private PreparedStatement preparedStatement; //usado para inserir informações no sql
    private String status;

    public Usuario getLogin(String login) {
        Usuario usuario = null;

        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = "SELECT * FROM usuario WHERE login = ?";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.preparedStatement.setString(1, login);
            this.resultSet = this.preparedStatement.executeQuery();
            System.out.println(this.sql);
            while (this.resultSet.next()) {
                usuario = new Usuario();
                usuario.setPermissao(this.resultSet.getString("permissao"));
                usuario.setLogin(this.resultSet.getString("login"));
                usuario.setSenha(new BCryptPasswordEncoder().encode(this.resultSet.getString("senha")));
                //fez a consulta no BD e troxe esse usuario com esses valores
                return usuario;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Usuario getUsuario(Long id_usuario) {
        Usuario usuario = new Usuario();
        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = " SELECT * FROM usuario WHERE id_usuario = ?";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.preparedStatement.setLong(1, id_usuario);
            this.resultSet = this.preparedStatement.executeQuery();
            while (resultSet.next()){
                usuario.setId(resultSet.getLong("id_usuario"));
                usuario.setLogin(resultSet.getString("login"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setPermissao(resultSet.getString("permissao"));
            }

        } catch (SQLException e){
            e.printStackTrace();
        }
        return usuario;
    }
    public Usuario cadastrar(Usuario usuario){

        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = "INSERT INTO usuario (login, senha, permissao) VALUES (?, ?, 'USER')";
            this.preparedStatement = connection.prepareStatement(sql);
            this.preparedStatement.setString(1, usuario.getLogin());
            this.preparedStatement.setString(2, usuario.getSenha());
            this.preparedStatement.execute();

        }catch (SQLException e){
            e.printStackTrace();
        }
        return usuario;
    }
    public Usuario editar(Usuario usuario, Long id_usuario){

        try (Connection connection = new ConectaBD().getConexao()){
            this.sql = "UPDATE usuario SET login = ?, senha = ?, permissao = ? WHERE id_usuario = ?";
            this.preparedStatement = connection.prepareStatement(sql);
            this.preparedStatement.setString(1, usuario.getLogin());
            this.preparedStatement.setString(2, usuario.getSenha());
            this.preparedStatement.setString(3, usuario.getPermissao());
            this.preparedStatement.setLong(4, id_usuario);
            this.preparedStatement.execute();

        } catch (SQLException e){
            e.printStackTrace();
        }
        return usuario;
    }
    public void excluir(Long id_usuario){

        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = " DELETE FROM usuario WHERE id_usuario = ?";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.preparedStatement.setLong(1, id_usuario);
            this.preparedStatement.executeQuery();

        } catch (SQLException e){
            e.printStackTrace();
        }
    }

}
