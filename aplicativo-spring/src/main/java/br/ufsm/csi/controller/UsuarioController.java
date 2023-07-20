package br.ufsm.csi.controller;

import br.ufsm.csi.dao.UsuarioDao;
import br.ufsm.csi.model.Usuario;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/usuario")
public class UsuarioController {

    @GetMapping("/{id_usuario}")
    //localhost:8080/usuario/numero
    public Usuario getUsuario(@PathVariable Long id_usuario){
        return new UsuarioDao().getUsuario(id_usuario);
    }
    @PostMapping("/adicionar")
    @ResponseStatus(code = HttpStatus.CREATED)
    //localhost:8080/usuario/adicionar + json com os dados
    public Usuario addUsuario(@RequestBody Usuario usuario){
        return new UsuarioDao().cadastrar(usuario);
    }
    @PutMapping("/{id_usuario}")
    //localhost:8080/usuario/numero + json com valores que deseja ser alterado no corpo da requisição
    public ResponseEntity updateUsuario(@PathVariable Long id_usuario, @RequestBody Usuario usuario){
        Usuario updated = new UsuarioDao().editar(usuario, id_usuario);
        return ResponseEntity.ok().body(updated);
    }
    @DeleteMapping("/{id_usuario}")
    //localhost:8080/usuario/numero
    public ResponseEntity<Void> deleteUsuario(@PathVariable Long id_usuario){
        new UsuarioDao().excluir(id_usuario);
        return ResponseEntity.noContent().<Void>build();
    }

}
