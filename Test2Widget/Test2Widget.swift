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
        let storeData = StoreData(showText: "-", clockedIn: false)
        
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
        //        var entries: [SimpleEntry] = []
        //
        //        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        //        let currentDate = Date()
        //        for hourOffset in 0 ..< 5 {
        //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //            let entry = SimpleEntry(date: entryData)
        //            entries.append(entry)
        //        }
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
    
    //    let timer = Timer.publish(every: 86400, on: .init(), in: .current, options: .default)
    
    @State var status: String = ""
    @State var buttonTitle: String = "Button not clicked"
    @State var text: String = ""
    @State var text2: String = ""
    var clockedIn: Bool
    var entry: Provider.Entry
    //@State var text.self = entry.storeData.showText
    // var timer : Timer? = nil
    func updateText(){
        text = "checkin bangg!!!!"
    }
    
    let formatter = DateFormatter()
    let calendar = Calendar.current
    var body: some View {
        
        let chromeWebsiteURL = URL(string: "googlechrome://smashswift.com")!
        
        
        ZStack{
            
                Text(text2).font(.system(size: 24, weight: .bold, design: .default)).onAppear()
                
            
            //ini text untuk data dari button 'udah ngab'
            
            
            
            //ContainerRelativeShape().fill(.gray.gradient)
            //ini text untuk ngebilang kalo perlu check-in
            //perlu dibuat untuk 2 situasi:
            //  situasi jam 12 subuh
            //  sitasi 8:50
            
            
//            Text(text).font(.system(size: 24, weight: .bold, design: .default)).onAppear()
            
            
            
            
            Text(text).font(.system(size: 24, weight: .bold, design: .default)).onAppear{
                
                //                let calendar = Calendar.current
                //                var dateComponents = DateComponents()
                //                dateComponents.hour = 24 //jam 12 subuh
                //
                //                //dateComponents.minute = 50
                //                //                let next850am = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime)!
                //                let next24am = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime)!
                //
                //                var timer = Timer(fireAt: next24am, interval: 24 * 60 * 60, target: self, selector: #selector(resetText), userInfo: nil, repeats: true)
                //                RunLoop.current.add(timer, forMode: .common)
                
                //masih kendala kenapa ini @obj ga bisa"
                
                //jadi rencannya itu reset widget ngebilang checkin bang tiap hari jam 12 tengah malam. terus kalo udah check in, ntar itu disembunyiin, trs diganti ke text baru
                
                self.updateText()
                
                // Schedule timer to call updateText function every 24 hours
//                let timer = Timer(fire: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 9, minute: 24), matchingPolicy: .nextTime)!, interval: 86400, repeats: true) { _ in
//                    self.updateText()
//                }
                
//                let now = Date()
//                        formatter.dateFormat = "HH:mm"
//                        let timeString = formatter.string(from: now)
//
//                        let widgetText = now.hour == 0 && now.minute == 0 ? "Midnight!" : timeString
//
//                        return Text(widgetText)
                //RunLoop.main.add(timer, forMode: .common)
                
                let now = Date()
                        formatter.dateFormat = "HH:mm"
                        let timeString = formatter.string(from: now)
                        
                        let hour = calendar.component(.hour, from: now)
                        let minute = calendar.component(.minute, from: now)
                        
//                        text = hour == 11 && minute == 13 ? "Midnight!" : "Checkin bang"
                if((hour == 0 && minute==0) && (hour<=13 && minute <= 17)){
                    text = "CHeckin bang"
                    text2 = ""
                    
                }else if(!(hour<=13 && minute <= 17) && clockedIn){
                    text = ""
                    text2 = "Nice, you have checked-in"
                    
                }

                
                
                        Text(text)
                
                
            }
            
            
        }
        
        
        VStack (alignment: .leading){
            //default valuenya itu ini  |
            //                          |
            //                          V
            
            //            Text("Don't forget to clock in, (username)! ").font(.system(size: 24, weight: .bold, design: .default))
            
            Text(status).font(.system(size: 24, weight: .bold, design: .default))
            //tapi kyknya default valuenya harus diganti sesui kondisi aslinya tpi itu bakal melibatkan real time krn ada timer di 8:50 dan juga aplikasi CiCo itu sendiri which is hard
            Link(destination: URL(string: "https://google.com")!){
                Text("Go To CiCo app")
                //pergi ke app CiCo dari deeplink dari main app
                
                
            }
            Button(action: {
                buttonTitle = "Button clicked"
                
                //                if let url = URL(string: "googlechrome://smashswift.com"){
                //                    UIApplication.shared.open(url)
                //                }
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
            Test2WidgetEntryView(clockedIn: entry.storeData.clockedIn, entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Test2Widget_Previews: PreviewProvider {
    static let storeData = StoreData(showText: "-", clockedIn: false)
    static var previews: some View {
        Test2WidgetEntryView(clockedIn: storeData.clockedIn, entry: SimpleEntry(storeData: storeData))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
