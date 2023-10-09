//
//  DataController.swift
//  Nano04
//
//  Created by Kauane Santana on 04/10/23.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "JogadorBD")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Salvo!")
        }
        
        catch {
            print("Não salvou :(")
        }
    }
    
    
    
    func addJogador(nome: String, ponto: String, cor: String, context: NSManagedObjectContext) {
        let jogador = Jogador(context: context)
        let intPonto = Int64(ponto)
        jogador.id = UUID()
        jogador.nome = nome
        jogador.ponto = intPonto ?? 0
        jogador.cor = cor
        
        save(context: context)
    }
    
    func editarJogador(jogador: Jogador, nome: String, ponto: String, context: NSManagedObjectContext) {
        let intPonto = Int64(ponto)
        jogador.nome = nome
        jogador.ponto = intPonto ?? 0
        
        save(context: context)
    }
    
    
    func deleteJogador(jogador: Jogador, context: NSManagedObjectContext) {
        context.delete(jogador)
        save(context: context)
    }
    
    
    func deleteAllJogador(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Jogador> = Jogador.fetchRequest()
        
        do {
            let jogadores = try context.fetch(fetchRequest)
            for jogador in jogadores {
                context.delete(jogador)
            }
            save(context: context)
        }
        catch {
            print("Não foi possível deletar todos os jogadores :(")
        }
    }
    
    func countJogadores(context: NSManagedObjectContext) -> Int?{
        let fetchRequest: NSFetchRequest<Jogador> = Jogador.fetchRequest()
        let count = try? context.count(for: fetchRequest)
        print(count ?? 13)
        return count
    }
    
}
