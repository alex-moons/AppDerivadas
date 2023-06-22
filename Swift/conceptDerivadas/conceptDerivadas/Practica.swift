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
    @Binding var grado:Int
    @State private var title:String = "Práctica"
    @State private var check:Bool = false
    @State private var next:Bool = false
    @State private var currentPage = 0
    @State var listProb2:[PolyProb]
    @State private var usrInput: String = ""
    @State private var progressTime = 0
    
    init(problems: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._problems = problems
        self._config = config
        self._grado = grado
        _listProb2 = State(initialValue: [PolyProb(problem: genPoly(grado: grado.wrappedValue), usrAnsw: "")])
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .dynamicTypeSize(.large)
            
            SeccionIndiv(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)

            NumberPadView(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                .padding(.all)
            
            Controls(currentPage: $currentPage, listProb2: $listProb2, grado: $grado, title: $title, config: $config, progressTime: $progressTime)
        }
        .padding()
    }
}

struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problems: .constant([true, false, false, false]), config:.constant(true), grado: .constant(3))
    }
}

func genPoly(grado:Int)->Polynomial{
    let problem = Polynomial(terms: [Term]())
    let _: () = problem.generate(minVal: -9, maxVal: 9, degree: grado)
    let _: () = problem.orderTerms()
    print("Generado: \(problem.toString())")
    return problem
}

struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var usrInput: String

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach((0..<listProb2.count), id: \.self) { i in
                VStack(alignment: .center){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.indigo)
                            .frame(height: 30)
                        Text(String(i+1))
                            .foregroundColor(Color.white)
                    }
                    .scaledToFit()
                    ProblemView(problem: listProb2[i].problem)
                }
                .padding(.bottom)
            }
        }
        .frame(height: 150)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
        .onChange(of: currentPage, perform: { index in
            usrInput = listProb2[currentPage].usrAnsw
        })
    }
}

struct ProblemView: View {
    @State var problem:Polynomial
    var body: some View {
        LaTeX("f(x) = " + problem.toLatex())
            .parsingMode(.all)
    }
}


struct NumberPadView: View {
    @State private var insertIndex: Int = 0
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var usrInput: String

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
                            listProb2[currentPage].usrAnsw = usrInput
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
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int

    var body: some View {
        VStack{
            Button("Check"){
                if listProb2[currentPage].check(){
                    print("correcto!")
                }else{
                    print("incorrecto")
                    print(listProb2[currentPage].usrAnsw)
                    print(listProb2[currentPage].answ)
                }
            }
            .padding()
        
            HStack{
                Button(action:{
                    print("prev Ch")
                }){
                    Image(systemName: "chevron.left.2")
                }
                .padding()
                
                Button(action:{
                    if currentPage > 0{
                        currentPage -= 1
                    }
                }){
                    Image(systemName: "chevron.left")
                }
                .padding()
                
                Button(action:{
                    if currentPage+1 < listProb2.count{
                        currentPage += 1
                    }else{
                        listProb2.append(PolyProb(problem: genPoly(grado: grado), usrAnsw: ""))
                        currentPage = listProb2.count-1
                        print("Curr: \(currentPage)")
                        print("Max: \(listProb2.count)")

                    }

                }){
                    Image(systemName: "chevron.right")
                }
                .padding()
                
                NavigationLink(destination: Resultados(results: $listProb2, time: $progressTime)){
                    Image(systemName: "chevron.right.2")
                }
                .padding()
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    VStack{
                        if config{
                            StopWatch(parentProgressTime: $progressTime)
                        }
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}




