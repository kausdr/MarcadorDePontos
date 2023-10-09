//
//  AddJogadorView.swift
//  Nano04
//
//  Created by Kauane Santana on 04/10/23.
//

import SwiftUI
import CoreData

struct AddJogadorView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    
    
    @State var nome: String = "FULANO"
    @State var ponto: String = "0"
    @Binding var showSheet: Bool
    @Binding var deleteAllButton: Bool
    @Binding var cor: String
    @Binding var previousColor: String
    @Binding var currentColor: String
    
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            
            
            VStack (spacing: 10){
                VStack {
                    Button {
                        showSheet = false
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 50, height: 50)
                            .font(.system(size: 30))
                            .foregroundColor(Color("FontUniversal"))
                            .background(Color("Bg"))
                            .cornerRadius(10)
                    }
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        .cornerRadius(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                .frame(maxWidth: 280, alignment: .trailing)
                .padding(.horizontal, 10)
                
                
                VStack{
                    Text("Jogador")
                        .font(.body)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .foregroundColor(Color(uiColor: .lightGray))
                    
                    
                    VStack {
                        TextField("Nome", text: $nome)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("FontCard"))
                            .background(Color(uiColor: .systemGray2))
                            .cornerRadius(10)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                                }
                            }
                        
                        TextField("0", text: $ponto)
                            .keyboardType(.numberPad)
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("FontCard"))
                            .background(Color(uiColor: .systemGray2))
                            .cornerRadius(10)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                                }
                            }
                    }
                    Button {
                        cor = generateRandomColorFromSet()
                        DataController().addJogador(nome: nome, ponto: ponto, cor: cor, context: managedObjContext)
                        
                        if DataController().countJogadores(context: managedObjContext) != 0 {
                            deleteAllButton = true
                        }
                        
                        showSheet.toggle()
                    } label: {
                        VStack {
                            Text("OK")
                                .foregroundColor(Color("FontUniversal"))
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(10)
                        .background(Color("Azul"))
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 3)
                            )
                            .cornerRadius(10)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                .frame(width: 280, height: 280)
                .padding(10)
                .background(Color(uiColor: .systemGray4))
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3)
                    )
                    .cornerRadius(10)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        
    }
    
    func generateRandomColorFromSet() -> String {
        //        let myColors: [String] = ["Amarelo", "Azul", "Laranja", "Rosa", "Roxo", "Vermelho"]
        //
        //        let randomIndex = Int.random(in: 0..<myColors.count)
        //        return myColors[randomIndex]
        
        let myColors: [String] = ["Amarelo", "Azul", "Laranja", "Rosa", "Roxo", "Vermelho"]
        
        var randomIndex = Int.random(in: 0..<myColors.count)
        
        // Ensure the next color is different from the previous one
        while myColors[randomIndex] == previousColor {
            randomIndex = Int.random(in: 0..<myColors.count)
        }
        
        previousColor = currentColor
        currentColor = myColors[randomIndex]
        return currentColor
    }
}

//#Preview {
//    AddJogadorView(showSheet: .constant(false), editView: .constant(false))
//}
