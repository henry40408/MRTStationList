//
//  MRTStationList.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/4.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import SwiftyJSON

enum MRTStationListError: ErrorType {
    case NoDataReceived
}

class MRTStationList {
    func fetch() -> Observable<[String:MRTStationLine]> {
        return Observable<[String:MRTStationLine]>.create { observer in
            Alamofire.request(.GET, "https://goo.gl/U3UykG")
                .responseData { response in
                    guard let data = response.data else {
                        observer.on(.Error(MRTStationListError.NoDataReceived))
                        observer.on(.Completed)
                        return
                    }
                    
                    let json = JSON(data: data)

                    var lines:[String:MRTStationLine] = [:]

                    for (_, item) in json {
                        var station = MRTStation(name: item["name"].stringValue, coordinate: [item["coordinate"].arrayValue[0].floatValue, item["coordinate"].arrayValue[1].floatValue], serials: [:])

                        for (key, item_2) in item["lines"] {
                            station.serials[key] = item_2.stringValue

                            if lines[key] == nil {
                                lines[key] = MRTStationLine(name: key, stations: [])
                            }

                            lines[key]!.stations.append(station)
                        }
                    }
                    
                    observer.on(.Next(lines))
                    observer.on(.Completed)
                }

            return NopDisposable.instance
        }
    }
}