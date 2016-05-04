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
    func fetch() -> Observable<[MRTStation]> {
        return Observable<[MRTStation]>.create { observer in
            Alamofire.request(.GET, "https://goo.gl/U3UykG")
                .responseData { response in
                    guard let data = response.data else {
                        observer.on(.Error(MRTStationListError.NoDataReceived))
                        observer.on(.Completed)
                        return
                    }
                    
                    let json = JSON(data: data)

                    var stations:[MRTStation] = []
                    
                    for (_, item) in json {
                        var station = MRTStation(name: item["name"].stringValue, coordinate: [item["coordinate"].arrayValue[0].floatValue, item["coordinate"].arrayValue[1].floatValue], lines: [])
                        
                        for (key, item_2) in item["lines"] {
                            station.lines.append(Line(name: key, serial: item_2.stringValue))
                        }

                        stations.append(station)
                    }

                    observer.on(.Next(stations))
                    observer.on(.Completed)
                }
            return NopDisposable.instance
        }
    }
}