//
//  MRTStation.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/4.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

struct MRTStation {
    var name: String
    var coordinate: [Float]
    var serials: [String:String]
}

struct MRTStationLine {
    var name: String
    var stations: [MRTStation]
}