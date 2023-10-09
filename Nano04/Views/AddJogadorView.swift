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
                            .foregroundColor(Color(uiColor: .systemRed))
                            .background(Color(uiColor: .white))
                            .cornerRadius(10)
                    }
                    
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
                            .background(Color(uiColor: .systemGray2))
                            .cornerRadius(10)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                                }
                            }
                    }
                    Button {
                        DataController().addJogador(nome: nome, ponto: ponto, context: managedObjContext)
                        
                        if DataController().countJogadores(context: managedObjContext) != 0 {
                            deleteAllButton = true
                        }
                        
                        showSheet.toggle()
                    } label: {
                        VStack {
                            Text("OK")
                                .foregroundColor(Color(uiColor: .systemBlue))
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(10)
                        .background(Color(uiColor: .white))
                        .cornerRadius(10)
                        
                    }
                }
                .frame(width: 280, height: 280)
                .padding(10)
                .background(Color(uiColor: .systemGray4))
                .cornerRadius(10)
            }
            
        }
        
    }
}

//#Preview {
//    AddJogadorView(showSheet: .constant(false), editView: .constant(false))
//}
