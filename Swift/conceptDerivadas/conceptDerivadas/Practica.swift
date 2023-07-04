//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Practica: View {
    @Binding var problemConfig:[Bool]
    @Binding var config:Bool
    @Binding var grado:Int
    @State var listProb2:[PolyProb]
    @State var problems:Problems
    @State private var title:String = "Práctica"
    @State private var usrInput: String = ""
    @State private var currentPage = 0
    @State private var currentSection = 0
    @State private var progressTime = 0
    
    init(problemConfig: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._problemConfig = problemConfig
        self._config = config
        self._grado = grado
        self._currentSection = State(initialValue: problemConfig.wrappedValue.firstIndex(where: { $0 })!)
        _listProb2 = State(initialValue: [PolyProb(problem: genPoly(grado: grado.wrappedValue), usrAnsw: "")])
        problems = Problems(grado: grado.wrappedValue)
    }
    
    var body: some View {
        let responseMessages = [0: "general",
                                1: "de la cadena",
                                2: "del producto",
                                3: "del cociente"]
        
        VStack(alignment: .center) {
            TabView(selection: $currentSection){
                ForEach(problemConfig.indices, id: \.self) { i in
                    if problemConfig[i]{
                        VStack{
                            Text("Encuentra la derivada de la siguiente función utilizando la regla \(responseMessages[i]!):")
                                .dynamicTypeSize(.large)
                            SeccionIndiv(currentPage: $currentPage, problemType: i, problems: $problems, listProb2: $listProb2, usrInput: $usrInput)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            
            NumberPadView(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput)
                .padding(.all)
            
            Controls(problemConfig: $problemConfig, problems: $problems, currentSection: $currentSection, currentPage: $currentPage, listProb2: $listProb2, grado: $grado, title: $title, config: $config, progressTime: $progressTime)
        }
        .padding()
    }
}

struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problemConfig: .constant([false, false, true, true]), config:.constant(true), grado: .constant(3))
    }
}

func toLatex(input:String)->String{
    var usrInput:String = input
    usrInput = usrInput.replacingOccurrences(of: "(", with: "{")
    usrInput = usrInput.replacingOccurrences(of: ")", with: "}")
    usrInput = usrInput.replacingOccurrences(of: "*", with: "")
    return usrInput
}

struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @State var problemType:Int
    @Binding var problems:Problems
    @Binding var listProb2:[PolyProb]
    @Binding var usrInput: String

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach((0..<listProb2.count), id: \.self) { i in
                VStack(){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.indigo)
                            .frame(width: 35, height: 35)
                        Text(String(i+1))
                            .foregroundColor(Color.white)
                    }
                    .frame(alignment: .top)
                    switch problemType{
                        case 3:
                        ProblemView(rule: problems.quo[i].problem)
                            .frame(height: 100, alignment: .top)
                            .border(listProb2[i].correct ? .green : .clear)
                        case 2:
                        ProblemView(rule: problems.prod[i].problem)
                            .frame(height: 100, alignment: .top)
                            .border(listProb2[i].correct ? .green : .clear)
                            .scaledToFit()
                        case 1:
                        ProblemView(rule: problems.chain[i].problem)
                            .frame(height: 40, alignment: .top)
                            .border(listProb2[i].correct ? .green : .clear)
                        default:
                        ProblemView(rule: problems.poly[i].problem)
                            .frame(height: 40, alignment: .top)
                            .border(listProb2[i].correct ? .green : .clear)
                    }
                }
                .frame(alignment: .top)
                .scaledToFill()
                .padding()
            }
        }
        .frame(height: 180, alignment: .top)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
        .onChange(of: currentPage, perform: { index in
            usrInput = listProb2[currentPage].usrAnsw
        })
    }
}

struct ProblemView<T: Rule>: View {
    @State var rule:T
    var body: some View {
        if let product = rule as? ProductRule {
            VStack(alignment: .trailing){
                let components = product.toLatex().components(separatedBy: "*")
                LaTeX("f(x) = " + components[0])
                    .parsingMode(.all)
                    .font(.title2)
                    .scaledToFill()
                    .frame(height: 50)
                LaTeX("*" + components[1])
                    .parsingMode(.all)
                    .font(.title2)
                    .scaledToFill()
                    .frame(height: 50)
            }
        }
        else {
            LaTeX("f(x) = " + rule.toLatex())
                .parsingMode(.all)
                .font(.title2)
                .scaledToFill()
        }
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
                        .disabled(true)
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

//Métodos para determinar la siguiente seccion a mostrar
func nextTrue(current:Int, problemConfig:[Bool])->Int{
    let nextIndex = problemConfig[(current + 1)...].firstIndex(where: { $0 })
    return nextIndex!
}
func prevTrue(current:Int, problemConfig:[Bool])->Int{
    let previousIndex = problemConfig[..<current].lastIndex(where: { $0 })
    return previousIndex!
}

struct Controls: View{
    @Binding var problemConfig:[Bool]
    @Binding var problems:Problems
    @Binding var currentSection:Int
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int
    //cada bool representa si está en el inicio de las secciones (0) o problemas (1), para deshabilitar los botones
    @State private var limit:(Bool, Bool) = (true, true)
    
    var body: some View {
        VStack{
            Button("Checar"){
                switch currentSection{
                case 3:
                    print(problems.quo[currentPage].correct ? "correcto" : "incorrecto")
                case 2:
                    print(problems.quo[currentPage].correct ? "correcto" : "incorrecto")
                case 1:
                    print(problems.quo[currentPage].correct ? "correcto" : "incorrecto")
                default:
                    print(problems.quo[currentPage].correct ? "correcto" : "incorrecto")
                }
            }
            .padding()
        
            HStack{
                //Seccion Previa
                Button(action:{
                    if currentSection > problemConfig.firstIndex(where: { $0 })!{
                        currentSection = prevTrue(current: currentSection, problemConfig: problemConfig)
                    }else{
                        limit.0 = true
                    }
                    print("prev Ch")
                }){
                    Image(systemName: "chevron.left.2")
                }
                .padding()
                .disabled(limit.0)
                
                //Problema anterior
                Button(action:{
                    if currentPage == 1{
                        currentPage -= 1
                        limit.1 = true
                    }else{
                        currentPage -= 1
                    }
                }){
                    Image(systemName: "chevron.left")
                }
                .padding()
                .disabled(limit.1)
                
                //Siguiente Problema
                Button(action:{
                    if currentPage+1 < listProb2.count{
                        currentPage += 1
                        limit.1 = false
                    }else{
                        listProb2.append(PolyProb(problem: genPoly(grado: grado), usrAnsw: ""))
                        currentPage = listProb2.count-1
                        limit.1 = false
                        print("Curr: \(currentPage)")
                        print("Max: \(listProb2.count)")
                    }

                }){
                    Image(systemName: "chevron.right")
                }
                .padding()
                
                //Siguiente seccion. Si estás en la última sección, navega a resultados.
                if currentSection >= problemConfig.lastIndex(of: true)!{
                    NavigationLink(destination: Resultados(results: $listProb2, time: $progressTime)){
                        Image(systemName: "chevron.right.2")
                    }
                    .padding()
                }else{
                    Button(action:{
                        currentSection = nextTrue(current: currentSection, problemConfig: problemConfig)
                        limit.0 = false
                    }){
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
        .onChange(of: currentSection, perform: { index in
            if currentSection == problemConfig.firstIndex(where: { $0 })!{
                limit.0 = true
            }else{
                limit.0 = false
            }
        })
        .onChange(of: currentPage, perform: { index in
            if currentPage == 0{
                limit.1 = true
            }else{
                limit.1 = false
            }
        })
    }
}



