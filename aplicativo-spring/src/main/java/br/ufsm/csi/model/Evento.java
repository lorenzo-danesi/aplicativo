package br.ufsm.csi.model;

import java.sql.Date;
import java.sql.Time;

public class Evento {
    private int id;
    private String nome;
    private String data;
    //private Date data;
    private String hora;
    //private Time hora;

    public Evento(int id, String nome, String data, String hora) {
        this.id = id;
        this.nome = nome;
        this.data = data;
        this.hora = hora;
    }

    public Evento() {
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getData() {
        return data;
    }
    public void setData(String data) {
        this.data = data;
    }
    public String getHora() {
        return hora;
    }
    public void setHora(String hora) {
        this.hora = hora;
    }
}
