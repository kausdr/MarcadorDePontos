//
//  AddJogadorView.swift
//  Nano04
//
//  Created by Kauane Santana on 04/10/23.
//

import SwiftUI
import CoreData

struct RemoveAllJogadores: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjContext
    
    
    @State var nome: String = "FULANO"
    @State var ponto: String = "0"
    @Binding var removerTodos: Bool
    @Binding var deleteAllButton: Bool
    @Binding var doDelete: Bool
    
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            
            VStack {
                VStack (spacing: 10){
                    Spacer()
                    
                    VStack{
                        Text("Tem certeza de que deseja apagar todos os placares?")
                            .font(.body)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: colorScheme == .dark ? .white : .black))
                            .padding(30)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: .systemGray2))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            removerTodos.toggle()
                        } label: {
                            VStack {
                                Text("NÃO")
                                    .foregroundColor(Color(uiColor: .systemBlue))
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color(uiColor: .white))
                            .cornerRadius(10)
                            
                        }
                        
                        
                        
                        Button {
                            DataController().deleteAllJogador(context: managedObjContext)
                            if DataController().countJogadores(context: managedObjContext) == 0 {
                                deleteAllButton = false
                            }
                            doDelete.toggle()
                            removerTodos.toggle()
                        } label: {
                            VStack {
                                Text("SIM")
                                    .foregroundColor(Color(uiColor: .systemRed))
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color(uiColor: .white))
                            .cornerRadius(10)
                            
                        }
                        .sensoryFeedback(.success, trigger: doDelete)
                    }
                    
                    
                    Spacer()
                    
                }
                .padding(10)
                
            }
            .frame(width: 280, height: 280)
            .padding(10)
            .background(Color(uiColor: .systemGray4))
            .cornerRadius(10)
            
        }
        
    }
}
