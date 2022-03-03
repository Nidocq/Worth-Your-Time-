//
//  SelectionScreen.swift
//  Worth your time?
//
//  Created by Phillip Lundin on 24/02/2022.
//

import SwiftUI
import AVKit

struct SelectionScreen: View {
    var backgroundColor = Color("myGreen")
    @State var hourlyPay : Int = 100
    
    
    @State var audioPlayer: AVAudioPlayer!
    
    @State var isCountingActive = false
    
    @State var jobTypes = ["Part time", "Full time"]
    @State var jobTypesSelection = "Part time"
    
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                    .zIndex(0)

                VStack {
                    Text("Worth Your time?")
                        .foregroundColor(.black)
                    Text(hourlyPay, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .bold()
                        .font(.system(size: 60))
                        .foregroundColor(.black)
                  
                    Spacer()
                    VStack(spacing: 10) {
                        Spacer()
                        Text("How much do you earn per hour?")
                            .font(.system(size: 17, weight: .bold ))
                            .foregroundColor(.black)
                            .padding()
                        Picker("fulltime", selection: $jobTypesSelection) {
                            ForEach(jobTypes, id: \.self) { job in
                                Text(job)
                                // depending on what view, make a new view and spawn that view based on this selection
                            }
                        }
                        .padding(3)
                        .pickerStyle(.segmented)
                        .background(Color("gold"))
                        .cornerRadius(10)
                        
                        Picker("hourly pay", selection: $hourlyPay) {
                            Text("Hourly wage selector")
                            ForEach(1..<1000, id: \.self) { hour in
                                ZStack {
                                    Text(hour, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                        .foregroundColor(.black)
                                        .bold()
                                        

                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        //.background()


                        Spacer()

                        NavigationLink(destination: CounterScreen(selectedHour: hourlyPay, bgC: Color("myGreen")), isActive: $isCountingActive) {
                            Text("Start timer")
                                .bold()
                                .padding()
                                .background(Color("gold"))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .onTapGesture {
                                    self.audioPlayer.play()
                                    isCountingActive = true
                                }
                        }
                        Spacer()
                    }
                    .padding(8)
                    .background(Color(red: 240/255, green: 240/255, blue: 240/255, opacity: 100))
                    .fixedSize()
                    .cornerRadius(5)
                    .shadow(color: .black, radius: 15, x: 13, y: 10)
                    
                    
                Spacer()
                }

            }
            .onAppear(perform: {
                let sound = Bundle.main.path(forResource: "click", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            })
            .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                 Button(action: {
                   print("Refresh")
                 }) {
                   Label("Send", systemImage: "gearshape.fill")
                     .padding()
                     .foregroundColor(Color("gold"))
                     .font(.system(size: 25))
                 }
               }
               ToolbarItem(placement: .navigationBarTrailing) {
                 Button(action: {
                   print("Refresh")
                 }) {
                   Label("Refresh", systemImage: "dollarsign.circle")
                     .padding()
                     .foregroundColor(Color("gold"))
                     .font(.system(size: 25))
                 }
               }
             }
      }
    }
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectionScreen()
    }
}
