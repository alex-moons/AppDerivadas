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
    @State private var showAnswer:Bool = false
    @State private var showCheck:Bool = false
    
    init(alumno: Binding<Alumno>, problemConfig: Binding<[Bool]>, config: Binding<Bool>, grado: Binding<Int>) {
        self._alumno = alumno
        self._problemConfig = problemConfig
        self._config = config
        self._grado = grado
        _problems = State(initialValue: [newProblem(problemConfig: problemConfig.wrappedValue, grado: grado.wrappedValue)])
    }
    
    //La vista padre de todas las subvistas
    var body: some View {
        VStack(alignment: .center) {
            Text("Encuentra la derivada de la siguiente función utilizando la regla correspondiente:")
                .dynamicTypeSize(.large)
            
            //Vista para los los problemas individuales
            SeccionIndiv(currentPage: $currentPage, problems: $problems, usrInput: $usrInput)
                .overlay(showCheck ? (checkCorrect):(nil))

            
            //Se encarga del teclado
            NumberPadView(currentPage: $currentPage, usrInput: $usrInput, problems: $problems)
                .padding(.all)
            
            //Se encargra de los botones de navegación
            Controls(alumno: $alumno, problemConfig: $problemConfig, currentPage: $currentPage, grado: $grado, title: $title, config: $config, progressTime: $progressTime, problems: $problems, showAnswer: $showAnswer, showCheck: $showCheck)
        }
        .padding()
        .overlay(showAnswer ? (correctAnsw):(nil))

    }
    var checkCorrect: some View{
        Rectangle()
            .frame(width: .infinity, height: .infinity)
            .foregroundColor(Color.green)
            .opacity(0.1)
    }
    
    var correctAnsw: some View{
        ZStack{
            //Opaca el fondo cuando se muestra la respuesta correcta
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            //if-else de la respuesta correcta que se muestra
            VStack(alignment: .center){
                if let problem = problems[currentPage] as? PolyProb {
                    VStack(alignment: .center){
                        Text("General")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("La respuesta correcta es:")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal){
                            LaTeX("f'(x)=  \(problem.problem.differentiate().toLatex())")
                                .parsingMode(.all)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding()
                } else if let problem = problems[currentPage] as? ChainProb {
                    VStack{
                        Text("Cadena")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("La respuesta correcta es:")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal){
                            LaTeX("f'(x)=  \(problem.problem.diffLatex())")
                                .parsingMode(.all)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding()
                } else if let problem = problems[currentPage] as? ProdProb {
                    VStack{
                        Text("Producto")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("La respuesta correcta es:")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal){
                            LaTeX("f'(x)=  \(problem.problem.diffLatex())")
                                .parsingMode(.all)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding()
                } else if let problem = problems[currentPage] as? QuoProb {
                    VStack{
                        Text("Cociente")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("La respuesta correcta es:")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal){
                            LaTeX("f'(x)= \(problem.problem.diffLatex())")
                                .parsingMode(.all)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .padding()
                }
                
                VStack{
                    Button("Cerrar") {
                        showAnswer = false
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()

            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
        }
    }
}

//Define los parámetros base para propósitos de desarrollo
struct Practica_Previews: PreviewProvider {
    static var previews: some View {
        Practica(alumno: .constant(Alumno(nombre: "", id: "")), problemConfig: .constant([true, false, false, false]), config:.constant(true), grado: .constant(1))
    }
}

//Sirve para dar una prevista de la $usrInput en Latex
func answToLatex(input:String)->String{
    var usrInput:String = input
    usrInput = usrInput.replacingOccurrences(of: "(", with: "{")
    usrInput = usrInput.replacingOccurrences(of: ")", with: "}")
    usrInput = usrInput.replacingOccurrences(of: "*", with: "")
    return usrInput
}

//Define cómo se genera un problema en base al arreglo de configuración
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
        return PolyProb(problem: genPoly(grado: grado, poly: true), usrAnsw: "")
    }
}

//Vista de la sección individual del problema
struct SeccionIndiv: View {
    @Binding var currentPage:Int
    @Binding var problems:[Any]
    @Binding var usrInput: String
    @State var isCorrect:Bool = false

    var body: some View {
        //Multiples vistas en páginas
        TabView(selection: $currentPage) {
            ForEach((0..<problems.count), id: \.self) { i in
                VStack{
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
                    .padding()
                    
                    
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
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        //Habilitar el tabView para poder regresarte a problemas anteriores.
        .disabled(false)
        //Que se muestre la respuesta del problema activo
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

//Vista que contiene el LaTex, usa protocolo para que pueda recibir lo que sea.
struct ProblemView<T:Rule>: View {
    @State var problem:T
    var body: some View {
        //Los problemas del producto son muy largos, entonces se dividen en 3 vistas
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
            .fixedSize(horizontal: true, vertical: true)
            .frame(width: 200)
        }else{
            //Los otros 3 problemas si caben
            LaTeX("f(x) = " + problem.toLatex())
                .parsingMode(.all)
                .font(.title2)
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: 200)
        }
    }
}

//Vista de la respuesta y el teclado
struct NumberPadView: View {
    @State private var insertIndex: Int = 0
    @State private var preview = false
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
                //Permite deslizar el texto si es mucho que escribir
                ScrollView(.horizontal){
                    //Vista LaTex super puesta para que pueda aparecer si se pica al botón
                    ZStack(alignment: .leading){
                        TextField("Respuesta", text: $usrInput)
                            .opacity(preview ? 0 : 1)
                            .disabled(true)
                            .frame(width: .infinity)
                        
                        LaTeX(answToLatex(input: usrInput))
                            .parsingMode(.all)
                            .opacity(preview ? 1 : 0)
                            .frame(width: .infinity)
                    }
                }

                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .onTapGesture {
                        (preview ? (preview = false):(preview = true))
                    }
                    .padding(.trailing)
            }
            .padding(.leading)
            .padding(.bottom)
            
            //Generación de las teclas individuales
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
                            //Actualizar la respuesta del usuario en cada problema individual con cada tecla activada
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
                                .frame(width: 50, height: 50)
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

//Maneja los botones de navegación
struct Controls: View {
    @Binding var alumno:Alumno
    @Binding var problemConfig:[Bool]
    @Binding var currentPage:Int
    @Binding var grado:Int
    @Binding var title:String
    @Binding var config:Bool
    @Binding var progressTime: Int
    @Binding var problems:[Any]
    @Binding var showAnswer:Bool
    @Binding var showCheck:Bool

    var body: some View {
        VStack{
            HStack{
                //Si se revisa se llama al método correspondiente
                Button("Revisar"){
                    if let problem = problems[currentPage] as? PolyProb {
                        problem.check()
                        (problem.correct ? (showCheck = true):(showAnswer = true))
                    } else if let problem = problems[currentPage] as? ChainProb {
                        problem.check()
                        (problem.correct ? (showCheck = true):(showAnswer = true))
                    } else if let problem = problems[currentPage] as? ProdProb {
                        problem.check()
                        (problem.correct ? (showCheck = true):(showAnswer = true))
                    } else if let problem = problems[currentPage] as? QuoProb {
                        problem.check()
                        (problem.correct ? (showCheck = true):(showAnswer = true))
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
                    showAnswer = false
                    showCheck = false

                }
                .padding()
            }

            NavigationLink(destination: Resultados(results: $problems, time: $progressTime, alumno: $alumno)){
                Text("Terminar")
            }
            .isDetailLink(false)
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
