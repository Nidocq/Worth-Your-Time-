//
//  CounterScreen.swift
//  Worth your time?
//
//  Created by Phillip Lundin on 24/02/2022.
//
// inpiration from https://stackoverflow.com/questions/58562063/create-a-navigationlink-without-back-button-swiftui

// elapsed timer https://stackoverflow.com/questions/63765532/swiftui-how-to-run-a-timer-in-background

import SwiftUI

struct CounterScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var selectedHour : Int
    @State var total : Int = 0
    @State var seconds : Int = 0
    @State var minutes : Int = 0
    @State var hours : Int = 0
    
    @State var StopTimerAlert : Bool = false
    
    func calcMoneyEarned() -> Double {
        let secondMoney = Double(selectedHour) * (Double(total) / 3600)
        return secondMoney
    }
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    var bgC : Color
    @State var now = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            bgC
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack { // Top yellow card
                Text("you have earned")
                    .font(.system(size: 17))
                    .foregroundColor(.black)
                Text(Double(calcMoneyEarned()), format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .font(.system(size: 60))
                    .foregroundColor(.black)
                Text("Hours \(String(hours)) : Minutes \(String(minutes)) : Seconds \(String(seconds))")
                    .font(.system(size:17))
                    .opacity(0.75)
                    .foregroundColor(.black)
                    .onReceive(timer) { sec in
                        guard isActive else { return }
                        print("time since : \(now.timeIntervalSince(Date()))")
                        
                        let elapsedTime = round(abs(now.timeIntervalSince(Date())))
                        withAnimation {
                            if (elapsedTime > 2) {
                                total += Int(round(elapsedTime))
                                
                                let elapsedMinutes = Int(elapsedTime)/60
                                let elapsedSeconds = Double(elapsedTime).truncatingRemainder(dividingBy: 60.0)
                                
                                seconds += Int(elapsedSeconds)
                                
                                if (elapsedMinutes >= 60) {
                                    minutes = Int(Double(elapsedMinutes).truncatingRemainder(dividingBy: 60.0))
                                    hours += (elapsedMinutes / 60)
                                } else {
                                    minutes += elapsedMinutes
                                }
                                print("\(elapsedSeconds) seconds added, \(elapsedMinutes), minutes added")
                            }
                            
                            now = Date()
                            print(seconds)
                            seconds += 1
                            total += 1
                            if (seconds >= 60) {
                                minutes += (seconds / 60)
                                seconds = 0
                            }
                        }
                    }
                    .onChange(of: scenePhase) { onChange in
                        if (onChange == .active) {
                            isActive = true
                        } else {
                            isActive = false
                        }
                    }
                }
                .frame(width: 300)
                .padding()
                .background(Color("gold"))
                .cornerRadius(25)
                .shadow(color: .black, radius: 10, x: 0, y: 7)
                    
                
                Spacer()

                VStack(alignment: .center) { // quote and picture
                    Text("Time to")
                        .bold()
                    Text("💸")
                        .bold()
                        .font(.system(size: 90))
                    Text("earn some money!")
                        .bold()
                }
                .foregroundColor(.white)
                
                Spacer()
                Button { // Yellow stop timer
                   StopTimerAlert = true
                }
                    label:  {
                        HStack {
                            Text("Stop timer")
                                .bold()
                                .padding()
                            Image(systemName: "timer")
                                .padding()
                        }
                        .foregroundColor(.black)
                        .background(Color("gold"))
                        .font(.system(size: 30))
                        .padding(.top, 5)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 10, x: 0, y: 7)

                
                    }
                    .alert("this is important", isPresented: $StopTimerAlert) {
                        Button("No") {}
                        Button("Yes") {
                            isActive = false
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } message: {
                        Text("Are you sure you want to stop the timer now?")
                    }
                
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {now = Date()})
        
    }
}

struct CounterScreen_Previews: PreviewProvider {
    static var previews: some View {
        CounterScreen(selectedHour: 123, bgC: Color(red: 71/255, green: 119/255, blue: 61/255, opacity: 1.0))
    }
}
