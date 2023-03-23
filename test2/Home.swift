//
//  Home.swift
//  test2
//
//  Created by ichiro on 15/03/23.
//

import SwiftUI

struct ContentView : View{
    
    
    @State private var firstName = ""
    @State private var sesiPagi = false
    @State private var sesiSiang = false
    @State private var clockedIn = false
    @State private var isButtonVisible = false
    let formatter = DateFormatter()
    let calendar = Calendar.current
    var thisDate = DateComponents()
//    thisDate.hour = 8;
//    thisDate.minute = 50;
//    let trigger = UNCalendarNotificationTrigger(dateMatching: thisDate, repeats: true)
    
    var body: some View{
        
        
        NavigationView{
            Form{
                
                TextField("1. ", text: $firstName)
                Toggle("Sesi pagi", isOn: $sesiPagi)
                Toggle("Sesi siang", isOn: $sesiSiang)
                
                //cara buat kalo salah satu toggle dihidupin, toggle yg lain ga bisa diotak-atik itu gmn?
            }.navigationTitle("Remind me to :")
                .toolbar{
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        //  Toggle("", isOn: $sesiPagi)
                        Button("Sesi pagi", action: sendData).offset(x: -100)
                        Button("Save", action: sendData).onAppear()
                        
                        //cara buat buttonnya muncul di jam penting aja biar ga bisa diotak atik
                       // if ((!clockedIn ) && !(isButtonVisible)){
                          //  if !clockedIn{
                        //false di sini brti ngeshow
                        
                        
                        
                        //tpi kalau codenya diupdate, dia bakal show sekali tapi langsung hilang krn kebaca value true di validasi bawahnya
                        if isButtonVisible == false{
                            
                            Button("Udah ngabb", action: udahNgab).onAppear{
                                
                                
                                //                                Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                                //                                    let calendar = Calendar.current
                                //                                    let now = Date()
                                //                                    let components = calendar.dateComponents([.hour, .minute], from: now)
                                //
                                //                                    if components.hour
                                //                                        == 23 && components.minute == 49{
                                //                                        isButtonVisible = true
                                //                                    }
                                //                                }
                                
//                                let nineAM = Calendar.current.date(bySettingHour: 6, minute: 13, second: 0, of: Date())!
//                                let timerToShowButton = Timer(fire: nineAM, interval: 0, repeats: false) { _ in
//                                                isButtonVisible = true
//                                            }
//                                            RunLoop.main.add(timerToShowButton, forMode: .common)
//
//                                            // Schedule the button to disappear at 5 PM
//                                let fivePM = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
//
//                                let nineFiveTeen = Calendar.current.date(bySettingHour: 9, minute: 16, second: 0, of: Date())!
//
//                                let timerToHideButton = Timer(fire: fivePM, interval: 0, repeats: false) { _ in
//                                                isButtonVisible = false
//                                            }
//
//
//                                let timerToHideButton2 = Timer(fire: nineFiveTeen, interval: 0, repeats: false) { _ in
//                                                isButtonVisible = false
//                                            }
//
//                                            RunLoop.main.add(timerToHideButton, forMode: .common)
//
//                                RunLoop.main.add(timerToHideButton2, forMode: .common)
                    
                                
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    let now = Date()
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: now)
                                    let minute = calendar.component(.minute, from: now)
                                    
                                    //buat butotn visible di 8:49 sampe 9:15
                                    
                                    //kalo false brti dia show button, kalo true brti hide button. GATAU KNP INI VALUENYA KLO DIBALIK JDI BISA WKKWKW
                                    if (hour >= 8 && minute >= 50 )
                                        {
                                        isButtonVisible = false
                                    }
//                                    if (hour >= 17 && minute >= 50){
//                                        isButtonVisible = true
//                                    }
                                    else {
                                        isButtonVisible = true
                                    }
                                }
                                
                                
                            }
                            
                            
                            // }
                            
                        }
                    }
                    
                    
                }
            
        }
        
    }

    


    func sendData(){
        print("data sent")
        storeData(text: firstName, clockedIn: true)
        //storeData(text: "Nice, you have checked-in!")
    }
    func gantiSesi(){
        
    }
    
    func udahNgab(){
        clockedIn.toggle()
        storeData(text: "Nice, you have checked-in!", clockedIn: clockedIn)
    }
    
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        
        ContentView()
    }
}

func storeData(text: String, clockedIn: Bool){
    //bikin initialization pakai suruhan check in setiap hari. berarti harus main ama tanggal
    let storeData = StoreData(showText: text, clockedIn: clockedIn)
    
    let primaryData = SecondHouse(storeData: storeData)
    primaryData.encodeData()
    
}


//func getTimeLine(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ())

