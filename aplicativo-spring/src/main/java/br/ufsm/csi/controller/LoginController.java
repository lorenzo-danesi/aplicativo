package br.ufsm.csi.controller;

import br.ufsm.csi.dao.UsuarioDao;
import br.ufsm.csi.model.Usuario;
import br.ufsm.csi.security.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @CrossOrigin(origins = "*")
    @PostMapping("/login")
    public ResponseEntity<Object> autenticacao(@RequestBody Usuario usuario){

        System.out.println("login: "+usuario.getLogin());
        System.out.println("senha: "+usuario.getSenha());
        try{
                final Authentication authentication = this.authenticationManager
                        .authenticate(new UsernamePasswordAuthenticationToken(usuario.getLogin(), usuario.getSenha()));

                if(authentication.isAuthenticated()){
                    //colocamos nossa instancia autenticada no contexto do spring security
                    SecurityContextHolder.getContext().setAuthentication(authentication);

                    Usuario user = new UsuarioDao().getLogin(usuario.getLogin());
                    System.out.println("Gerando token de autorização ****");
                    String token = new JWTUtil().geraToken(usuario);

                    user.setToken(token);
                    usuario.setSenha("");

                    return new ResponseEntity<>(user, HttpStatus.OK);
                }

        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("Usuário ou senha incorretos!", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>("Usuário ou senha incorretos!", HttpStatus.BAD_REQUEST);
    }
}
