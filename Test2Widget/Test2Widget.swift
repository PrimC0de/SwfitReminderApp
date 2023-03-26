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
    @State var text: String = ""
    @State var text2: String = ""
    var status: String
    
    var entry: Provider.Entry
    
    func updateText(){
        text = "checkin bangg!!!!"
    }
    
    let formatter = DateFormatter()
    let calendar = Calendar.current
    var body: some View {
        
        let chromeWebsiteURL = URL(string: "googlechrome://smashswift.com")!
        ZStack{
            
            Text(text2).font(.system(size: 24, weight: .bold, design: .default)).onAppear()

            Text(text).font(.system(size: 24, weight: .bold, design: .default)).onAppear{
                
                let now = Date()
                formatter.dateFormat = "HH:mm"
                let timeString = formatter.string(from: now)
                
                let hour = calendar.component(.hour, from: now)
                let minute = calendar.component(.minute, from: now)
                
                if((hour == 0 && minute==0) && (hour<=13 && minute <= 17)){
                    text = "CHeckin bang"
                    text2 = ""
                    
                }else if(!(hour<=13 && minute <= 17) && status == "Sudah Clock-In"){
                    text = ""
                    text2 = "Nice, you have checked-in"
                    
                }
                Text(text)
            }
        }
        
        VStack(alignment: .leading) {
            Text(status).font(.system(size: 24, weight: .bold, design: .default))
            Link(destination: URL(string: "https://google.com")!){
                Text("Go To CiCo app")
            }
            Button(action: {
                buttonTitle = "Button clicked"
            }){
                
                Text("Clock in now")
            }
        }
        
    }
}

struct Test2Widget: Widget {
    let kind: String = "Test2Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Test2WidgetEntryView(status: entry.storeData.status, entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Test2Widget_Previews: PreviewProvider {
    static let storeData = StoreData(showText: "-", status: "Belum Clock-In")
    static var previews: some View {
        Test2WidgetEntryView(status: storeData.status, entry: SimpleEntry(storeData: storeData))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
