//
//  SecondHouse.swift
//  test2
//
//  Created by ichiro on 15/03/23.
//

import SwiftUI
import WidgetKit

struct SecondHouse {
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.binus")) var primaryData : Data = Data()
    
    let storeData: StoreData
    
    func encodeData(){
        guard let data = try? JSONEncoder().encode(storeData) else{
            return
        }
        
        primaryData = data
        WidgetCenter.shared.reloadAllTimelines()
    }
}

