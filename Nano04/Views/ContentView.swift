//
//  ContentView.swift
//  Nano04
//
//  Created by Kauane Santana on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id, order: .forward)]) var jogador: FetchedResults<Jogador>
    
    @State var showSheet: Bool = false
    @State var editView: Bool = false
    @State var removerTodos: Bool = false
    @State var deleteAllButton: Bool = false
    @State var doDelete: Bool = false
    @State var exitEdit: Bool = false
    @State var openEditView: Bool = false
    @State var isKeyboardVisible: Bool = false
    
    @State var index: Int = 0
    @State var pontoAdded: Bool = false
    
    @State var chosenJogador: Jogador!
    
    @State private var fontSize: CGFloat = 20.0
    
    var myColors: [String] = ["Amarelo", "Azul", "Laranja", "Rosa", "Roxo", "Vermelho"]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if jogador.isEmpty {
                        Text("Crie um placar :)")
                            .foregroundStyle(Color(uiColor: .systemGray2))
                        
                    }
                    else {
                        ScrollView{
                            LazyVGrid(columns: columns, spacing: 10) {
                                
                                ForEach(jogador) { jogador in
                                    VStack (spacing: 10){
                                        VStack {
                                            Text("\(jogador.nome ?? "")")
                                                .font(.title)
                                                .font(.system(size: fontSize))
                                                .minimumScaleFactor(0.5)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .cornerRadius(10)
                                            
                                            Text("\(jogador.ponto)")
                                                .font(.title)
                                                .font(.title)
                                                .font(.system(size: fontSize))
                                                .minimumScaleFactor(0.5)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .cornerRadius(10)
                                                
                                        }
                                        .background(Color(generateRandomColorFromSet()))
                                    }
                                    
                                    .onAppear {
                                        fontSize = calculateDynamicFontSize(for: jogador.nome ?? "")
                                    }
                                    .onTapGesture {
                                        jogador.ponto += 1
                                        pontoAdded.toggle()
                                    }
                                    .onLongPressGesture {
                                        chosenJogador = jogador
                                        editView.toggle()
                                        openEditView.toggle()
                                    }
                                    .sensoryFeedback(.success, trigger: openEditView)
                                    .sensoryFeedback(.success, trigger: pontoAdded)
                                    .foregroundColor(Color(uiColor: .white))
                                    .frame(width: 90, height: 90)
                                    .padding(10)
                                    .background(Color(generateRandomColorFromSet()))
//                                    .background(Color(jogador.cor))
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 2)
                                        )
                                        .cornerRadius(10)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    HStack {
                        Text("Placar")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack {
                        
                        if deleteAllButton {
                            Button {
                                removerTodos.toggle()
                            }
                        label: {
                            Image(systemName: "trash")
                                .foregroundColor(Color(uiColor: .systemRed))
                        }
                        .padding(.trailing, 26)
                        }
                        
                        
                        Button {
                            showSheet.toggle()
                        }
                    label: {
                        Image(systemName: "plus.circle")
                    }
                        
                        
                    }
                }
            }
            
        }
        .onAppear {
            if DataController().countJogadores(context: managedObjContext) != 0 {
                deleteAllButton = true
            }
            else {
                deleteAllButton = false
            }
        }
        .overlay {
            if showSheet {
                AddJogadorView(showSheet: $showSheet, deleteAllButton: $deleteAllButton)
            }
            
            if editView {
                RemoveJogadorView(jogador: chosenJogador, editView: $editView, deleteAllButton: $deleteAllButton, exitEdit: $exitEdit)
            }
            
            if removerTodos {
                RemoveAllJogadores(removerTodos: $removerTodos, deleteAllButton: $deleteAllButton, doDelete: $doDelete)
            }
            
            
        }
    }
    
    func generateRandomColorFromSet() -> String {
        let randomIndex = Int.random(in: 0..<myColors.count)
        return myColors[randomIndex]
    }
}

func calculateDynamicFontSize(for text: String) -> CGFloat {
    var size: CGFloat = 20.0
    let boundingBox = CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
    let font = UIFont.systemFont(ofSize: size)
    
    while text.size(withAttributes: [.font: font]).width > boundingBox.width {
        size -= 1.0
    }
    
    return size
}

#Preview {
    ContentView()
}
