//
//  Test2Widget.swift
//  Test2Widget
//
//  Created by ichiro on 15/03/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //var clockedIn : Bool
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.binus")) var primaryData : Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        let storeData = StoreData(showText: "-", status: "Belum Clock-In")
        
        return SimpleEntry(storeData: storeData)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else{
            return
        }
        
        let entry = SimpleEntry(storeData: storeData)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else{
            return
        }
        
        let entry = SimpleEntry(storeData: storeData)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    let storeData : StoreData
}

@objc protocol myProtocol{
    @objc func resetText()
}

struct Test2WidgetEntryView : View {
    @State var buttonTitle: String = "Button not clicked"
    @State var status: String
    @State private var title = "Saatnya clock-in"
    let now = Date()
    
    var entry: Provider.Entry
    
    var body: some View {
        
        VStack {
            
            if (now <= makeTime(hour: 8, minute: 50) && now >= makeTime(hour: 6, minute: 00)) {
                // Sebelum Waktu
                Text("Hari Baru")
                    .font(Font.custom("Futura", size: 20))
            } else if now >= makeTime(hour: 8, minute: 50) && now <= makeTime(hour: 9, minute: 15) {
                // Waktu Clock In
                if (status == "Belum Clock-In") {
                    Text("Saatnya clock in")
                        .font(Font.custom("Futura", size: 20))
                } else if (status == "Sudah Clock-In") {
                    Text("Happy learning!")
                        .font(Font.custom("Futura", size: 20))
                } else {
                    Text("Saatnya clock in")
                        .font(Font.custom("Futura", size: 20))
                }
            } else if now >= makeTime(hour: 9, minute: 15) && now <= makeTime(hour: 12, minute: 50) {
                // Idle
                Text("Happy learning!")
                    .font(Font.custom("Futura", size: 20))
            } else if (now > makeTime(hour: 12, minute: 50) && now <= makeTime(hour: 13, minute: 00)) {
                // Waktu Clock Out
                if (status == "Belum Clock-Out" || status == "Sudah Clock-In") {
                    Text("Saatnya clock-out")
                        .font(Font.custom("Futura", size: 20))
                } else if (status == "Sudah Clock-Out") {
                    Text("See you again!")
                        .font(Font.custom("Futura", size: 20))
                } else {
                    Text("Happy learning!")
                        .font(Font.custom("Futura", size: 20))
                }
            } else {
                // Wkatu Setelah Clock Out
                Text("Hari baru!")
                    .font(Font.custom("Futura", size: 20))
            }
            
            
            Button(action: {
                
            }){
                Text("Go to RemindMe")
                    .font(Font.custom("Futura", size: 15))
                    .foregroundColor(.white)
                    .frame(width: 138, height: 35)
                    .background(Color(red: 26/255, green: 66/255, blue: 157/255))
                    .cornerRadius(30)
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
}

struct Test2Widget: Widget {
    let kind: String = "Test2Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Test2WidgetEntryView(status: entry.storeData.status, entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Test2Widget_Previews: PreviewProvider {
    static let storeData = StoreData(showText: "-", status: "Hari baru!")
    static var previews: some View {
        Test2WidgetEntryView(status: storeData.status, entry: SimpleEntry(storeData: storeData))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
