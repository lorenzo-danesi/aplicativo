package br.ufsm.csi.model;

public class Usuario {
    private long id;
    private String login;
    private String senha;
    private String permissao;
    private String token;

    public Usuario(String login, String senha, String permissao) {
        this.login = login;
        this.senha = senha;
        this.permissao = permissao;
    }

    public Usuario() {
    }

    public Usuario(Long id, String login, String senha, String permissao) {
        this.id = id;
        this.login = login;
        this.senha = senha;
        this.permissao = permissao;
    }

    public long getId() {
        return id;
    }
    public void setId(long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }
    public void setLogin(String login) {
        this.login = login;
    }
    public String getSenha() {
        return senha;
    }
    public void setSenha(String senha) {
        this.senha = senha;
    }
    public String getPermissao() {
        return permissao;
    }
    public void setPermissao(String permissao) {
        this.permissao = permissao;
    }
    public String getToken() {
        return token;
    }
    public void setToken(String token) {
        this.token = token;
    }
}
