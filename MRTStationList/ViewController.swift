//
//  ViewController.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/3.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UITableViewController {

    let CELL_REUSE_IDENTIFIER = "mrt_station"

    let stationList: MRTStationList = MRTStationList()

    var lines: [String:MRTStationLine] = [:]
    var lineTitles: [String] { return lines.keys.sort() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initForTableViewCell()
        fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initForTableViewCell() {
        self.tableView.rowHeight = 44
        self.tableView.allowsSelection = false
        self.tableView.registerNib(UINib(nibName: "MRTStationListCell", bundle: nil), forCellReuseIdentifier: CELL_REUSE_IDENTIFIER)
    }
    
    func fetchList() {
        _ = stationList.fetch()
            .subscribeNext { lines in
                for (key, line) in lines {
                    self.lines[key] = line
                }
                self.tableView.reloadData()
            }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return lineTitles.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return lineTitles[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let title: String = lineTitles[section]
        if let line: MRTStationLine = lines[title] {
            return line.stations.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_IDENTIFIER) as? MRTStationListCell

        if (cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("MRTStationListCell", owner: self, options: nil)[0] as? MRTStationListCell
        }
        
        let title: String = lineTitles[indexPath.section]

        let line: MRTStationLine = lines[title]!
        let station: MRTStation = line.stations[indexPath.row]
        cell?.nameLabel?.text = station.name

        let keys = Array(station.serials.keys)
        let values = Array(station.serials.values)

        if station.serials.count < 2 {
            cell?.lineLabel2?.hidden = true
        } else {
            cell?.lineLabel2?.text = values[1]
            cell?.lineLabel2?.textColor = UIColor.whiteColor()
            cell?.lineLabel2?.backgroundColor = cell?.colorMapping[keys[1]]
            cell?.lineLabel2?.layer.masksToBounds = true
            cell?.lineLabel2?.layer.cornerRadius = 4
        }

        cell?.lineLabel1?.text = values[0]
        cell?.lineLabel1?.textColor = UIColor.whiteColor()
        cell?.lineLabel1?.backgroundColor = cell?.colorMapping[keys[0]]
        cell?.lineLabel1?.layer.masksToBounds = true
        cell?.lineLabel1?.layer.cornerRadius = 4

        return cell!
    }
}

