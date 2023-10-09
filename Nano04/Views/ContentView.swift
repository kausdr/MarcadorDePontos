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
    
    @State var cor: String = "Amarelo"
    @State var previousColor = ""
    @State var currentColor = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if jogador.isEmpty {
                        Text("Crie um Placar\n:)")
                            .multilineTextAlignment(.center)
                            .font(.custom("YoungSerif-Regular", size: 20))
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
                                    .foregroundColor(Color(uiColor: .black))
                                    .frame(width: 90, height: 90)
                                    .padding(10)
                                    .background(Color("\(jogador.cor ?? "")"))
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.black, lineWidth: 3)
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
            .background(Color("AmareloClaro"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    HStack {
                        Text("Placar")
                            .font(.custom("YoungSerif-Regular", size: 30))
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
                            .foregroundColor(Color("Icon"))
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
                AddJogadorView(showSheet: $showSheet, deleteAllButton: $deleteAllButton, cor: $cor, previousColor: $previousColor, currentColor: $currentColor)
            }
            
            if editView {
                RemoveJogadorView(jogador: chosenJogador, editView: $editView, deleteAllButton: $deleteAllButton, exitEdit: $exitEdit)
            }
            
            if removerTodos {
                RemoveAllJogadores(removerTodos: $removerTodos, deleteAllButton: $deleteAllButton, doDelete: $doDelete)
            }
            
            
        }
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
