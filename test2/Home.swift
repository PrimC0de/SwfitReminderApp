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
    
    var thisDate = DateComponents()
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
                    Text("Clock-in ngab!!!")
                        .font(Font.custom("Futura", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 26/255, green: 66/255, blue: 157/255))
                    Spacer()
                    
                    VStack {
                        Image("Cico")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.85)
                        
                        Text("jangan lupa clock-in\nkalau udah di lokasi ya ngab")
                            .font(Font.custom("Futura", size: 20))
                            .multilineTextAlignment(.center)
                    }.offset(y: -15)
                    
                    Spacer()
                    
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
                    Spacer()
                }.padding(.vertical, 80).offset(y: -15)
            
            }
    }
    func sendData(){
        print("data sent")
        storeData(text: firstName)
        //storeData(text: "Nice, you have checked-in!")
    }
    func gantiSesi(){
        
    }
    
    func udahNgab(){
        
        storeData(text: "Nice, you have checked-in!")
    }
    
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        
        ContentView()
    }
}

func storeData(text: String){
    //bikin initialization pakai suruhan check in setiap hari. berarti harus main ama tanggal
    let storeData = StoreData(showText: text)
    
    let primaryData = SecondHouse(storeData: storeData)
    primaryData.encodeData()
    
}


//func getTimeLine(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ())

