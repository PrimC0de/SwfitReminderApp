//
//  Home.swift
//  test2
//
//  Created by ichiro on 15/03/23.
//

import SwiftUI

struct ContentView : View{
    
    @State private var phase = phases[0]

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
                        .frame(width: 400, height: 200)
                    
                    Text(phase.description)
                        .font(Font.custom("Futura", size: 20))
                        .multilineTextAlignment(.center)
                    
                }.offset(y: -12)
                
                Spacer()
                
                switch phase.status {
                case .belumClockIn:
                    Button(action: {
                        udahNgab()
                    }, label: {
                        EnabledButtonView(title: "Udah ngab")
                    })
                    
                case .sudahClockIn:
                    DisabledButtonView(title: "Selamat beraktivitas!")
                    
                case .belumClockOut:
                    Button(action: {
                        udahNgab()
                    }, label: {
                        EnabledButtonView(title: "Udah ngab")
                    })
                    
                case .sudahClockOut:
                    DisabledButtonView(title: "Sampai ketemu besok")
                    
                case .gantiHari:
                    DisabledButtonView(title: "Be on-time yaa")
                }
                
                Spacer()
            }.padding(.vertical, 80).offset(y: -15)
            
        }.onAppear{
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                let now = makeTime(hour: 8, minute: 30)
                
                if (now <= makeTime(hour: 8, minute: 50) && now >= makeTime(hour: 6, minute: 00)) {
                    phase = phases[4]
                    sendData()
                } else if now >= makeTime(hour: 8, minute: 50) && now <= makeTime(hour: 9, minute: 15) {
                    // Waktu Clock In
                    if (phase.status.rawValue == "Belum Clock-In") {
                        phase = phases[0]
                        sendData()
                    } else if (phase.status.rawValue == "Sudah Clock-In") {
                        phase = phases[1]
                        sendData()
                    } else {
                        phase = phases[0]
                        sendData()
                    }
                } else if now >= makeTime(hour: 9, minute: 15) && now <= makeTime(hour: 12, minute: 50) {
                    // Idle
                    phase = phases[1]
                    sendData()
                } else if (now > makeTime(hour: 12, minute: 50) && now <= makeTime(hour: 13, minute: 00)) {
                    // Waktu Clock Out
                    if (phase.status.rawValue == "Belum Clock-Out" || phase.status.rawValue == "Sudah Clock-In") {
                        phase = phases[2]
                        sendData()
                    } else if (phase.status.rawValue == "Sudah Clock-Out") {
                        phase = phases[3]
                        sendData()
                    } else {
                        phase = phases[1]
                        sendData()
                    }
                } else {
                    // Wkatu Setelah Clock Out
                    phase = phases[3]
                    sendData()
                }
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
        storeData(text: "", status: phase.status.rawValue)
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
        let storeData = StoreData(showText: text, status: phase.status.rawValue)
        
        let primaryData = SecondHouse(storeData: storeData)
        primaryData.encodeData()
    }
}

struct EnabledButtonView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(Font.custom("Futura", size: 20))
            .foregroundColor(.white)
            .frame(width: 200, height: 60)
            .background(Color(red: 26/255, green: 66/255, blue: 157/255))
            .cornerRadius(30)
    }
}

struct DisabledButtonView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(Font.custom("Futura", size: 20))
            .foregroundColor(Color(.black).opacity(0.6))
            .frame(width: 260, height: 60)
            .background(Color(.systemGray3).opacity(0.5))
            .cornerRadius(30)
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

