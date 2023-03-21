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
                        Button("Save", action: sendData)
                        Button("Udah ngabb", action: udahNgab)
                        
                    }
                }
            
            
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

