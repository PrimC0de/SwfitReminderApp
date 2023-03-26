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
    .init(title: "Saatnya clock-in", image: "CiCoReminder", description: "Jangan lupa untuk clock-in\napabila sudah di lokasi", status: .belumClockIn),
    .init(title: "Happy learning!", image: "ClockIn", description: "Selamat beraktivitas di\nApple Developer Academy @BINUS", status: .sudahClockIn),
    .init(title: "Saatnya clock-out", image: "CiCoReminder", description: "Jangan lupa untuk clock-out\nuntuk melengkapi presensi hari ini", status: .belumClockOut),
    .init(title: "See you again!", image: "ClockOut", description: "Selamat melanjutkan aktivitas\ndi rumah ataupun di academy", status: .sudahClockOut),
    .init(title: "Selamat pagi", image: "ClockOut", description: "Hati-hati di jalan\nsaat menuju ke academy", status: .gantiHari),
]

public enum Status: String, Codable {
    case belumClockIn = "Belum Clock-In"
    case sudahClockIn = "Sudah Clock-In"
    case belumClockOut = "Belum Clock-Out"
    case sudahClockOut = "Sudah Clock-Out"
    case gantiHari = "Ganti Hari"
}
