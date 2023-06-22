//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Practica: View {
    @Binding var problems:[Bool]
    @Binding var config:Bool
    @State private var check:Bool = false
    @State private var next:Bool = false
    @State private var page = (0,1)
    
    var body: some View {
        VStack(alignment: .center) {
//            StopWatch()
            
            Text("Regla General")
                .font(.title)
                .bold()

            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .padding()
                .dynamicTypeSize(.xLarge)
            
            SeccionIndiv(page: $page)

            NumberPadView()
                .padding(.all)
            
            Controls(page: $page)
        }
        .padding()
        
    }
}
struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problems: .constant([true,true,true,true]), config: .constant(true))
    }
}


struct SeccionIndiv: View {
    @Binding var page:(Int, Int)
    var body: some View {
        VStack{
            TabView(selection: $page.0) {
                ForEach((0..<page.1), id: \.self) { i in
                    VStack{
                        ProblemView()
                        Text(String(i+1))
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))
        }
        .frame(height: 90)
    }
}

struct ProblemView: View {
    var body: some View {
        let problem = Polynomial(terms: [Term]())
        let _: () = problem.generate(minVal: 0, maxVal: 9, degree: 4)
        let _: () = problem.orderTerms()
        
        LaTeX("f(x) = " + problem.toLatex())
            .parsingMode(.all)
    }
}


struct NumberPadView: View {
    @State private var usrInput: String = ""
    @State private var insertIndex: Int = 0

    let rows = [
        ["1", "2", "3", "^", "⌫"],
        ["4", "5", "6", "(", ")"],
        ["7", "8", "9", "﹡", "÷"],
        ["𝑥", "0", ".", "+", "-"]
    ]
    
    var body: some View {
        VStack(spacing: 7) {
            HStack{
                LaTeX("f'(x) =")
                    .parsingMode(.all)
                
                TextField("Respuesta", text: $usrInput)
            }
            .padding(.leading)
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 7) {
                    ForEach(row, id: \.self) { number in
                        Button(action: {
                            switch number{
                            case "⌫":
                                if usrInput.count > 0{
                                    usrInput.removeLast()
                                }
                            case "÷":
                                usrInput.append("/")
                            case "𝑥":
                                usrInput.append("x")
                            case "﹡":
                                usrInput.append("*")
                            default:
                                usrInput.append(number)
                            }
                        }, label: {
                            Text(number)
                                .font(.largeTitle)
                                .frame(width: 55, height: 55)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        })
                    }
                }
            }
        }
    }
}

struct Controls: View {
    @Binding var page:(Int,Int)
    var body: some View {
        VStack{
            Button("Answ"){}
            .padding()
        
            HStack{
                Button(action:{
                    print("prev Ch")
                }){
                    Image(systemName: "chevron.left.2")
                }
                .padding()
                
                Button(action:{
                    if page.0 > 0{
                        page.0 -= 1
                    }
                }){
                    Image(systemName: "chevron.left")
                }
                .padding()
                
                Button(action:{
                    print("button pressed")
                    if page.0+1 < page.1{
                        page.0 += 1
                    }else{
                        page.1 += 1
                        page.0 += 1
                    }
                }){
                    Image(systemName: "chevron.right")
                }
                .padding()
                
                Button(action:{
                    print("next Ch")
                }){
                    Image(systemName: "chevron.right.2")
                }
                .padding()
            }
        }
    }
}




