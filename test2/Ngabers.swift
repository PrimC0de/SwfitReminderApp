//
//  Ngabers.swift
//  test2
//
//  Created by Yuga Samuel on 22/03/23.
//

import Foundation

struct Ngabers {
    let id = UUID()
    let title: String
    let image: String
    let description: String
    let status: Status
}

enum Status {
    case belumClockIn
    case sudahClockIn
    case belumClockOut
    case sudahClockOut
}

extension Ngabers {
    static let allValues: [Ngabers] = [
        .init(title: "Clock-in ngab!!!", image: "CiCoReminder", description: "jangan lupa clock-in\nkalau udah di lokasi ya ngab", status: .belumClockIn),
        .init(title: "Mantap ngab..", image: "ClockIn", description: "selamat beraktivitas di\nApple Developer Academy @BINUS ya ngab", status: .belumClockIn),
        .init(title: "Clock-out ngab!!!", image: "CiCoReminder", description: "jangan lupa clock-out\nbiar ga dianggap absen ya ngab", status: .belumClockIn),
        .init(title: "Naise ngab..", image: "ClockOut", description: "selamat melanjutkan aktivitas\ndi rumah ataupun di academy ya ngab", status: .belumClockIn)
    ]
}
