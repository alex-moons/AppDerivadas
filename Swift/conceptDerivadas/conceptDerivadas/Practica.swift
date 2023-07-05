//
//  ContentView.swift
//  conceptDerivadas
//
//  Created by Alumno on 21/04/23.
//

import SwiftUI
import LaTeXSwiftUI

struct Practica: View {
    @Binding var alumno:Alumno
    @Binding var problemConfig:[Bool]
    @Binding var config:Bool
    @Binding var grado:Int
    @State private var title:String = "Práctica"
    @State private var problems:[Any] = []
    @State private var currentPage = 0
    @State private var usrInput: String = ""
    @State private var progressTime = 0
    
    init(alumno: Binding<Alumno>, problemConfig: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._alumno = alumno
        self._problemConfig = problemConfig
        self._config = config
        self._grado = grado
        _problems = State(initialValue: [newProblem(problemConfig: problemConfig.wrappedValue, grado: grado.wrappedValue)])
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .dynamicTypeSize(.large)
            
            SeccionIndiv(currentPage: $currentPage, problems: $problems, usrInput: $usrInput)
            
            NumberPadView(currentPage: $currentPage, usrInput: $usrInput, problems: $problems)
                .padding(.all)
            
            Controls(alumno: $alumno, problemConfig: $problemConfig, currentPage: $currentPage, grado: $grado, title: $title, config: $config, progressTime: $progressTime, problems: $problems)
        }
        .padding()
    }
}

struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(alumno: .constant(Alumno(nombre: "", id: "")), problemConfig: .constant([true, true, true, true]), config:.constant(true), grado: .constant(3))
    }
}

func answToLatex(input:String)->String{
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
        return QuoProb(problem: genQuo(grado: grado), usrAnsw: "")
    case 2:
        return ProdProb(problem: genProd(grado: grado), usrAnsw: "")
    case 1:
        return ChainProb(problem: genChain(grado: grado), usrAnsw: "")
    default:
        return PolyProb(problem: genPoly(grado: grado), usrAnsw: "")
    }
}

struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @Binding var problems:[Any]
    @Binding var usrInput: String

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach((0..<problems.count), id: \.self) { i in
                VStack(){
                    ZStack{
                        if let problem = problems[currentPage] as? PolyProb {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(problem.correct ? Color.green : Color.indigo)
                                .frame(width: 35, height: 35)
                        } else if let problem = problems[currentPage] as? ChainProb {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(problem.correct ? Color.green : Color.indigo)
                                .frame(width: 35, height: 35)
                        } else if let problem = problems[currentPage] as? ProdProb {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(problem.correct ? Color.green : Color.indigo)
                                .frame(width: 35, height: 35)
                        } else if let problem = problems[currentPage] as? QuoProb {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(problem.correct ? Color.green : Color.indigo)
                                .frame(width: 35, height: 35)
                        }
                        Text(String(i+1))
                            .foregroundColor(Color.white)
                    }
                    
                    if let problem = problems[currentPage] as? PolyProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 100)
                    } else if let problem = problems[currentPage] as? ChainProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 100)
                    } else if let problem = problems[currentPage] as? ProdProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 50)
                    } else if let problem = problems[currentPage] as? QuoProb {
                        ProblemView(problem: problem.problem)
                            .frame(height: 50)
                    }

                }
                .padding()
            }
        }
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
        if let product = problem as? ProductRule {
            HStack{
                LaTeX("f(x) = ")
                    .parsingMode(.all)
                VStack(){
                    let components = product.toLatex().components(separatedBy: "*")
                    LaTeX(components[0])
                        .parsingMode(.all)
                        .font(.title2)
                        .frame(height: 50)
                    LaTeX("*" + components[1])
                        .parsingMode(.all)
                        .font(.title2)
                        .frame(height: 50)
                }
            }
        }else{
            LaTeX("f(x) = " + problem.toLatex())
                .parsingMode(.all)
                .font(.title2)
        }
    }
}

struct NumberPadView: View {
    @State private var insertIndex: Int = 0
    @GestureState private var preview = false
    @Binding var currentPage:Int
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
                    LaTeX(answToLatex(input: usrInput))
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
    @Binding var alumno:Alumno
    @Binding var problemConfig:[Bool]
    @Binding var currentPage:Int
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int
    @Binding var problems:[Any]

    var body: some View {
        VStack{
            HStack{
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
                
                //Siguiente Problema
                Button("Siguiente"){
                    if currentPage+1 < problems.count{
                        currentPage += 1
                    }else{
                        problems.append(newProblem(problemConfig: problemConfig, grado: grado))
                        currentPage = problems.count-1
                        print("Curr: \(currentPage)")
                    }

                }
                .padding()
            }

            NavigationLink(destination: Resultados(results: $problems, time: $progressTime, alumno: $alumno)){
                Text("Terminar")
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



