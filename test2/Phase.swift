//
//  Phase.swift
//  test2
//
//  Created by Yuga Samuel on 23/03/23.
//

import Foundation

struct Phase: Codable {
    let title: String
    let image: String
    let description: String
    let status: Status
}

var phases: [Phase] = [
    .init(title: "Clock-in ngab!!!", image: "CiCoReminder", description: "jangan lupa clock-in\nkalau udah di lokasi ya ngab", status: .belumClockIn),
    .init(title: "Mantap ngab..", image: "ClockIn", description: "selamat beraktivitas di\nApple Developer Academy ya ngab", status: .sudahClockIn),
    .init(title: "Clock-out ngab!!!", image: "CiCoReminder", description: "jangan lupa clock-out\nbiar ga dianggap absen ya ngab", status: .belumClockOut),
    .init(title: "Naise ngab..", image: "ClockOut", description: "selamat melanjutkan aktivitas\ndi rumah ataupun di academy ngab", status: .sudahClockOut)
]

public enum Status: String, Codable {
    case belumClockIn = "Belum Clock-In"
    case sudahClockIn = "Sudah Clock-In"
    case belumClockOut = "Belum Clock-Out"
    case sudahClockOut = "Sudah Clock-Out"
}
