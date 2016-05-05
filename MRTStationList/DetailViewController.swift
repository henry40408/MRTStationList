//
//  DetailViewController.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/5.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var oneLineLabel: UILabel?
    @IBOutlet weak var twoLineLabel1: UILabel?
    @IBOutlet weak var twoLineLabel2: UILabel?

    var line: MRTStationLine?
    var station: MRTStation?

    override func viewDidLoad() {
        super.viewDidLoad()
        fillOut()
    }
    
    func fillOut() {
        guard let station$ = self.station else {
            return
        }

        let keys = Array(station$.serials.keys)
        self.nameLabel?.text = station$.name
        if keys.count > 1 {
            self.twoLineLabel1?.text = keys[0]
            self.twoLineLabel1?.backgroundColor = MRTStationListCell.colorMapping[keys[0]]
            self.twoLineLabel2?.text = keys[1]
            self.twoLineLabel2?.backgroundColor = MRTStationListCell.colorMapping[keys[1]]
            self.oneLineLabel?.hidden = true
        } else {
            self.oneLineLabel?.text = keys[0]
            self.oneLineLabel?.backgroundColor = MRTStationListCell.colorMapping[keys[0]]
            self.twoLineLabel1?.hidden = true
            self.twoLineLabel2?.hidden = true
        }
    }
    
    func setup(title: String, line: MRTStationLine, station: MRTStation) {
        self.title = title
        self.line = line
        self.station = station
    }
}
