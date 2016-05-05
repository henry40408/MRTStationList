//
//  MRTStationListCell.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/5.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

import UIKit

class MRTStationListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var lineLabel1: UILabel?
    @IBOutlet weak var lineLabel2: UILabel?

    static let colorMapping:[String:UIColor] = [
        "文湖線": UIColor(red: 158/255, green: 101/255, blue: 46/255, alpha: 1),
        "淡水信義線": UIColor(red: 203/255, green: 44/255, blue: 48/255, alpha: 1),
        "新北投支線": UIColor(red: 248/255, green: 144/255, blue: 165/255, alpha: 1),
        "松山新店線": UIColor(red: 0/255, green: 119/255, blue: 73/255, alpha: 1),
        "小碧潭支線": UIColor(red: 206/255, green: 220/255, blue: 0/255, alpha: 1),
        "中和新蘆線": UIColor(red: 255/255, green: 163/255, blue: 0/255, alpha: 1),
        "板南線": UIColor(red: 0/255, green: 94/255, blue: 184/255, alpha: 1),
        "貓空纜車": UIColor(red: 119/255, green: 185/255, blue: 51/255, alpha: 1)
    ]
}