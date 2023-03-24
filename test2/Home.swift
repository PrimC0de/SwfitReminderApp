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
    @State private var phase = phases[0]
    @State private var isButtonVisible = false
    @State private var currTime: String = "aa"
    let formatter = DateFormatter()
    
    var thisDate = DateComponents()
    
    let date = Date()
    let calendar = Calendar.current
    
    
    
    
    //    thisDate.hour = 8;
    //    thisDate.minute = 50;
    //    let trigger = UNCalendarNotificationTrigger(dateMatching: thisDate, repeats: true)
    
    var body: some View{
        ZStack {
            VStack {
                HStack {
                    Image("CloudTop")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -80)
                }
                Spacer()
                HStack {
                    Image("CloudBtm")
                        .resizable()
                        .scaledToFit()
                        .offset(y: 80)
                }
            }.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text(phase.title)
                    .font(Font.custom("Futura", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 26/255, green: 66/255, blue: 157/255))
                Spacer()
                
                VStack {
                    Image(phase.image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.85)
                    
                    Text(phase.description)
                        .font(Font.custom("Futura", size: 20))
                        .multilineTextAlignment(.center)
                }.offset(y: -15)
                
                Spacer()
                
                switch phase.status {
                    
                case .belumClockIn:
                    
                    Button(action: {
                        udahNgab()
                    }, label: {
                        Text("Udah Ngab")
                            .font(Font.custom("Futura", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 60)
                            .background(Color(red: 26/255, green: 66/255, blue: 157/255))
                            .cornerRadius(30)
                    })
                    
                case .sudahClockIn:
                    Text("")
                case .belumClockOut:
                    Button(action: {
                        udahNgab()
                    }, label: {
                        Text("Udah Ngab")
                            .font(Font.custom("Futura", size: 20))
                            .foregroundColor(.black)
                            .frame(width: 200, height: 60)
                            .background(Color(red: 255/255, green: 180/255, blue: 135/255))
                            .cornerRadius(30)
                            .shadow(radius: 5)
                    })
                case .sudahClockOut:
                    Text("phase 3")
                }
                
                Spacer()
            }.padding(.vertical, 80).offset(y: -15)
            
        }.onAppear{
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let now = makeTime(hour: 12, minute: 51)
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: now)
                let minute = calendar.component(.minute, from: now)
                
                if (now < makeTime(hour: 8, minute: 50)) {
                    // Sebelum Waktu
                    phase = phases[3]
                } else if now >= makeTime(hour: 8, minute: 50) && now <= makeTime(hour: 9, minute: 15){
                    // Waktu Clock In
                    
                    if (phase.status.rawValue == "Belum Clock-In") {
                        phase = phases[0]
                    } else if (phase.status.rawValue == "Sudah Clock-In") {
                        phase = phases[1]
                    } else {
                        phase = phases[0]
                    }
                } else if now >= makeTime(hour: 9, minute: 15) && now <= makeTime(hour: 12, minute: 50) {
                    // Idle
                    phase = phases[1]
                } else if (now > makeTime(hour: 12, minute: 50) && now <= makeTime(hour: 13, minute: 15)){
                    // Waktu Clock Out
                    if (phase.status.rawValue == "Belum Clock-Out" || phase.status.rawValue == "Sudah Clock-In") {
                        phase = phases[2]
                    } else if (phase.status.rawValue == "Sudah Clock-Out") {
                        phase = phases[3]
                    } else {
                        phase = phases[1]
                    }
                    
                } else {
                    // Wkatu Setelah Clock Out
                    currTime = "adsasd"
                    phase = phases[3]
                }
                
                
                
                
                //                if ((hour >= 8 && minute >= 50) && phase.status.rawValue == "Belum Clock-In")
                //                {
                //                    phase = phases[0]
                //                }
                //                else {
                //                    phase = phases[3]
                //                }
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        
        return dateString
    }
    
    func makeTime(hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
        components.day = calendar.component(.day, from: Date())
        components.hour = hour
        components.minute = minute
        let date = Calendar.current.date(from: components)!
        
        return date
    }
    
    func sendData(){
        print("data sent")
        storeData(text: firstName, status: phase.status.rawValue)
        //storeData(text: "Nice, you have checked-in!")
    }
    
    func udahNgab(){
        if (phase.status.rawValue == "Belum Clock-In") {
            phase = phases[1]
        } else {
            phase = phases[3]
        }
        
        storeData(text: "Nice, you have checked-in!", status: phase.status.rawValue)
    }
    
    func storeData(text: String, status: String){
        //bikin initialization pakai suruhan check in setiap hari. berarti harus main ama tanggal
        let storeData = StoreData(showText: text, status: phase.status.rawValue)
        
        let primaryData = SecondHouse(storeData: storeData)
        primaryData.encodeData()
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

