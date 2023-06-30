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
    @State private var currentSection = 0
    @State private var currentPage = 0
    @State var secciones:ListProb
    @State var listProb2:[PolyProb]
    @State private var usrInput: String = ""
    @State private var progressTime = 0
    
    
    init(problems: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._problems = problems
        self._config = config
        self._grado = grado
        
        let temp = ListProb(poly: [], chain: [], prod: [], quo: [])
        for index in problems.wrappedValue.indices{
            if problems[index].wrappedValue{
                switch index{
                case 1:
                    temp.chain = [ChainProb(problem: genChain(grado: grado.wrappedValue), usrAnsw: "")]
                case 2:
                    temp.prod = [ProdProb(problem: genProd(grado: grado.wrappedValue), usrAnsw: "")]
                case 3:
                    temp.chain = [ChainProb(problem: genChain(grado: grado.wrappedValue), usrAnsw: "")]
                default:
                    temp.poly = [PolyProb(problem: genPoly(grado: grado.wrappedValue), usrAnsw: "")]
                }
            }
        }
        self.secciones = temp
        _listProb2 = State(initialValue: [PolyProb(problem: genPoly(grado: grado.wrappedValue), usrAnsw: "")])
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack{
                if problems[0] && currentSection == 0{
                    VStack{
                        Text("Encuentra la derivada de la siguiente función utilizando la regla General")
                            .dynamicTypeSize(.large)
                        
//                        SeccionIndiv(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                    }
                }
                
                if problems[1] && currentSection == 0{
                    VStack{
                        Text("Encuentra la derivada de la siguiente función utilizando la regla de la Cadena")
                            .dynamicTypeSize(.large)
                        
                        SeccionIndiv(currentPage: $currentPage, listProb2: $secciones.poly, usrInput: $usrInput)
                    }
                }
                
                if problems[2] && currentSection == 0{
                    VStack{
                        Text("Encuentra la derivada de la siguiente función utilizando la regla del Producto")
                            .dynamicTypeSize(.large)
                        
//                        SeccionIndiv(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                    }
                }
                
                if problems[3] && currentSection == 0{
                    VStack{
                        Text("Encuentra la derivada de la siguiente función utilizando la regla del Cociente")
                            .dynamicTypeSize(.large)
                        
//                        SeccionIndiv(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                    }
                }
                
            }

            NumberPadView(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                .padding(.all)
            
            Controls(currentSection: $currentSection, currentPage: $currentPage, listProb2: $listProb2, grado: $grado, title: $title, config: $config, progressTime: $progressTime, problems: $problems)
        }
        .padding()
    }
}

struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problems: .constant([false, true, false, false]), config:.constant(true), grado: .constant(3))
    }
}

func toLatex(input:String)->String{
    var usrInput:String = input
    usrInput = usrInput.replacingOccurrences(of: "(", with: "{")
    usrInput = usrInput.replacingOccurrences(of: ")", with: "}")
    return usrInput
}

struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var usrInput: String

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach((0..<listProb2.count), id: \.self) { i in
                VStack(){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.indigo)
                            .frame(height: 30)
                        Text(String(i+1))
                            .foregroundColor(Color.white)
                    }
                    .scaledToFit()
                    .frame(alignment: .top)
                    ProblemView(rule: listProb2[i].problem)
                        .frame(height: 80, alignment: .top)
                }
                .frame(alignment: .top)
            }
        }
        .frame(height: 150, alignment: .top)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
        .onChange(of: currentPage, perform: { index in
            usrInput = listProb2[currentPage].usrAnsw
        })
    }
}

struct ProblemView<T: Rule>: View {
    @State var rule:T
    var body: some View {
        LaTeX("f(x) = " + rule.toLatex())
            .parsingMode(.all)
            .font(.title2)
    }
}


struct NumberPadView: View {
    @State private var insertIndex: Int = 0
    @GestureState private var preview = false
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
            HStack (alignment: .center){
                LaTeX("f'(x) =")
                    .parsingMode(.all)
                
                ZStack(alignment: .leading){
                    TextField("Respuesta", text: $usrInput,  axis: .vertical)
                        .opacity(preview ? 0 : 1)
                        .lineLimit(1...2)
                    LaTeX(toLatex(input: usrInput))
                        .parsingMode(.all)
                        .opacity(preview ? 1 : 0)
                }

                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                    .gesture(LongPressGesture(minimumDuration: 0.2).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local)).updating($preview) { value, state, _ in
                        switch value {
                            case .second(true, nil):
                                state = true
                            default:
                                break
                        }
                    })
                    .padding(.trailing)
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
    @Binding var currentSection:Int
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int
    @Binding var problems:[Bool]

    var body: some View {
        VStack{
            Button("Check"){
                listProb2[currentPage].check()
                if listProb2[currentPage].correct{
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
                    if currentSection != 0{
                        currentSection -= 1
                    }
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
                
                if currentSection != problems.filter({$0}).count{
                    Button(action:{
                        currentSection += 1
                        print("currentSection = \(currentSection)")
                    }){
                        Image(systemName: "chevron.right.2")
                    }
                    .padding()
                }else{
                    NavigationLink(destination: Resultados(results: $listProb2, time: $progressTime)){
                        Image(systemName: "chevron.right.2")
                    }
                    .padding()

                }
            }
        }
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




