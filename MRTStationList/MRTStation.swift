//
//  MRTStation.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/4.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

struct Line {
    var name: String
    var serial: String
}

struct MRTStation {
    var name: String
    var coordinate: [Float]
    var lines: [Line]
}