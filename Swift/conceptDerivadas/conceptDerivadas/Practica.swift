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
    @State private var title:String = "Práctica"
    @State private var problems:[Any] = []
    @State private var check:Bool = false
    @State private var next:Bool = false
    @State private var currentSection = 0
    @State private var currentPage = 0
    @State var listProb2:[PolyProb]
    @State private var usrInput: String = ""
    @State private var progressTime = 0
    
    init(problemConfig: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._problemConfig = problemConfig
        self._config = config
        self._grado = grado
        self._currentSection = State(initialValue: problemConfig.wrappedValue.firstIndex(where: { $0 })!)
        _listProb2 = State(initialValue: [PolyProb(problem: genPoly(grado: grado.wrappedValue), usrAnsw: "")])
        problems.append(newProblem(problemConfig: problemConfig.wrappedValue, grado: grado.wrappedValue))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack{
                Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                    .dynamicTypeSize(.large)
                
                SeccionIndiv(currentPage: $currentPage, listProb2: $listProb2, problems: $problems, usrInput: $usrInput)
            }
            
            NumberPadView(currentPage: $currentPage, listProb2: $listProb2, usrInput: $usrInput, problems: $problems)
                .padding(.all)
            
            Controls(problemConfig: $problemConfig, currentSection: $currentSection, currentPage: $currentPage, listProb2: $listProb2, grado: $grado, title: $title, config: $config, progressTime: $progressTime, problems: $problems)
        }
        .padding()
    }
}

struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(problemConfig: .constant([true, true, false, false]), config:.constant(true), grado: .constant(3))
    }
}

func toLatex(input:String)->String{
    var usrInput:String = input
    usrInput = usrInput.replacingOccurrences(of: "(", with: "{")
    usrInput = usrInput.replacingOccurrences(of: ")", with: "}")
    usrInput = usrInput.replacingOccurrences(of: "*", with: "")
    return usrInput
}

func newProblem(problemConfig: [Bool], grado:Int)->Any{
    var checked:[Int] = []
    for (index, value) in problemConfig.enumerated(){
        if value{
            checked.append(index)
        }
    }
    
    switch checked.randomElement(){
    case 3:
        return genQuo(grado: grado)
    case 2:
        return genProd(grado: grado)
    case 1:
        return genChain(grado: grado)
    default:
        return genPoly(grado: grado)
    }
}

struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var problems:[Any]
    @Binding var usrInput: String

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach((0..<problems.count), id: \.self) { i in
                VStack(){
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.indigo)
                            .frame(width: 35, height: 35)
                        Text(String(i+1))
                            .foregroundColor(Color.white)
                    }
                    .frame(alignment: .top)
                    
                    if let problem = problems[currentPage] as? PolyProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 40, alignment: .top)
                            .border(problem.correct ? .green : .clear)
                    } else if let problem = problems[currentPage] as? ChainProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 40, alignment: .top)
                            .border(problem.correct ? .green : .clear)
                    } else if let problem = problems[currentPage] as? ProdProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 40, alignment: .top)
                            .border(problem.correct ? .green : .clear)
                    } else if let problem = problems[currentPage] as? QuoProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 40, alignment: .top)
                            .border(problem.correct ? .green : .clear)
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
            if let problem = problems[currentPage] as? PolyProb {
                usrInput = problem.usrAnsw
            } else if let problem = problems[currentPage] as? ChainProb {
                usrInput = problem.usrAnsw
            } else if let problem = problems[currentPage] as? ProdProb {
                usrInput = problem.usrAnsw
            } else if let problem = problems[currentPage] as? QuoProb {
                usrInput = problem.usrAnsw
            }
        })
    }
}

struct ProblemView<T:Rule>: View {
    @State var problem:T
    var body: some View {
        LaTeX("f(x) = " + problem.toLatex())
            .parsingMode(.all)
            .font(.title2)
            .scaledToFill()
    }
}

struct NumberPadView: View {
    @State private var insertIndex: Int = 0
    @GestureState private var preview = false
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var usrInput: String
    @Binding var problems:[Any]


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
                            if let problem = problems[currentPage] as? PolyProb {
                                problem.usrAnsw = usrInput
                            } else if let problem = problems[currentPage] as? ChainProb {
                                problem.usrAnsw = usrInput
                            } else if let problem = problems[currentPage] as? ProdProb {
                                problem.usrAnsw = usrInput
                            } else if let problem = problems[currentPage] as? QuoProb {
                                problem.usrAnsw = usrInput
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
    @Binding var problemConfig:[Bool]
    @Binding var currentSection:Int
    @Binding var currentPage:Int
    @Binding var listProb2:[PolyProb]
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int
    @Binding var problems:[Any]

    var body: some View {
        VStack{
            HStack{
                //Siguiente Problema
                Button("Siguiente"){
                    if currentPage+1 < problems.count{
                        currentPage += 1
                    }else{
                        problems.append(newProblem(problemConfig: problemConfig, grado: grado))
                        currentPage = problems.count-1
                        print("Curr: \(currentPage)")
                        print("Max: \(listProb2.count)")
                    }

                }
                .padding()
                
                Button("Revisar"){
                    if let problem = problems[currentPage] as? PolyProb {
                        problem.check()
                        (problem.correct ? print("correcto"):print("incorrecto"))
                    } else if let problem = problems[currentPage] as? ChainProb {
                        problem.check()
                        (problem.correct ? print("correcto"):print("incorrecto"))
                    } else if let problem = problems[currentPage] as? ProdProb {
                        problem.check()
                        (problem.correct ? print("correcto"):print("incorrecto"))
                    } else if let problem = problems[currentPage] as? QuoProb {
                        problem.check()
                        (problem.correct ? print("correcto"):print("incorrecto"))
                    }
                }
                .padding()
            }
            
            Button("Terminar"){
                
            }
            .padding()
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



