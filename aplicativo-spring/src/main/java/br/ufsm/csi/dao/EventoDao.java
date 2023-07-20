package br.ufsm.csi.dao;

import br.ufsm.csi.model.Evento;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao {
    //declaração das variáveis
    private String sql;
    private Statement statement; //usado para trazer informações do sql
    private ResultSet resultSet;
    private PreparedStatement preparedStatement; //usado para inserir informações no sql
    private String status;

    public Evento getEvento(int id) {
        Evento evento = new Evento();
        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = " SELECT * FROM evento WHERE id = ?";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.preparedStatement.setInt(1, id);
            this.resultSet = this.preparedStatement.executeQuery();
            while (resultSet.next()){
                evento.setId(resultSet.getInt("id"));
                evento.setNome(resultSet.getString("nome"));
                evento.setData(resultSet.getString("data"));
                evento.setHora(resultSet.getString("hora"));

            }

        } catch (SQLException e){
            e.printStackTrace();
        }
        return evento;
    }

    public ArrayList<Evento> getEventos(){
        ArrayList<Evento> eventos = new ArrayList<Evento>();

        try (Connection connection = new ConectaBD().getConexao()){
            this.sql = "SELECT * FROM evento";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.resultSet = this.preparedStatement.executeQuery();
            while (resultSet.next()){
                Evento evento = new Evento();
                evento.setId(this.resultSet.getInt("id"));
                evento.setNome(this.resultSet.getString("nome"));
                evento.setData(resultSet.getString("data"));
                evento.setHora(resultSet.getString("hora"));
                eventos.add(evento);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return eventos;
    }

    public Evento adicionar(Evento evento){

        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = "INSERT INTO evento (nome, data, hora) VALUES (?, ?, ?)";
            this.preparedStatement = connection.prepareStatement(sql);
            this.preparedStatement.setString(1, evento.getNome());
            this.preparedStatement.setString(2, evento.getData());
            this.preparedStatement.setString(3, evento.getHora());
            this.preparedStatement.execute();

        }catch (SQLException e){
            e.printStackTrace();
        }
        return evento;
    }

    public Evento editar(Evento evento, int id){

        try (Connection connection = new ConectaBD().getConexao()){
            this.sql = "UPDATE evento SET nome = ?, data = ?, hora = ? WHERE id = ?";
            this.preparedStatement = connection.prepareStatement(sql);
            this.preparedStatement.setString(1, evento.getNome());
            this.preparedStatement.setString(2, evento.getData());
            this.preparedStatement.setString(3, evento.getHora());
            this.preparedStatement.setInt(5, id);
            this.preparedStatement.execute();

        } catch (SQLException e){
            e.printStackTrace();
        }
        return evento;
    }
    public void excluir(int id){
        try (Connection connection = new ConectaBD().getConexao()) {
            this.sql = " DELETE FROM evento WHERE id = ?";
            this.preparedStatement = connection.prepareStatement(this.sql);
            this.preparedStatement.setInt(1, id);
            this.preparedStatement.executeQuery();

        } catch (SQLException e){
            e.printStackTrace();
        }
    }
}
