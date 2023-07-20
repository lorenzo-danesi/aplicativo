package br.ufsm.csi.controller;

import br.ufsm.csi.dao.EventoDao;
import br.ufsm.csi.model.Evento;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/eventos")
public class EventoController {

    @GetMapping("/{id}")
    public Evento getEvento(@PathVariable int id) {
        return new EventoDao().getEvento(id);
    }

    @GetMapping("/lista")
    public ArrayList<Evento> getEventos() {
        return new EventoDao().getEventos();
    }

    @PostMapping("/adicionar")
    @ResponseStatus(code = HttpStatus.CREATED)
    public Evento adicionarEvento(@RequestBody Evento evento){
        return new EventoDao().adicionar(evento);
    }

    @PutMapping("/{id}")
    public ResponseEntity editarEvento(@PathVariable int id, @RequestBody Evento evento){
        Evento updated = new EventoDao().editar(evento, id);
        return ResponseEntity.ok().body(updated);
    }

    @CrossOrigin(origins = "*")
    @DeleteMapping("/{id}")
    public ResponseEntity deletarEvento(@PathVariable int id){
        new EventoDao().excluir(id);
        return ResponseEntity.noContent().<Void>build();
    }
}
