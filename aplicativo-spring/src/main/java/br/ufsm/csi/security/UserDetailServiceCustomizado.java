package br.ufsm.csi.security;

import br.ufsm.csi.dao.UsuarioDao;
import br.ufsm.csi.model.Usuario;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailServiceCustomizado implements UserDetailsService {
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("username: "+username);

        Usuario usuario = new UsuarioDao().getLogin(username);

        if(usuario == null){
            throw  new UsernameNotFoundException("Usuário ou senha inválidos");
        }else{
            UserDetails user = User.withUsername(usuario.getLogin())
                    .password(usuario.getSenha())
                    .authorities(usuario.getPermissao()).build();
            return user;
        }
    }
}
