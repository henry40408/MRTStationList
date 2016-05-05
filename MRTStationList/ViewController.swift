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

    let cellReuseIdentifier = "MRTStationCell"

    let stationList: MRTStationList = MRTStationList()

    var lines: [String:MRTStationLine] = [:]
    var lineTitles: [String] { return lines.keys.sort() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as? MRTStationListCell

        if (cell == nil) {
            cell = MRTStationListCell()
        }

        let title: String = lineTitles[indexPath.section]

        guard let line: MRTStationLine = lines[title] else {
            return cell!
        }

        guard let station: MRTStation = line.stations[indexPath.row] else {
            return cell!
        }

        cell?.nameLabel?.text = station.name

        let keys = Array(station.serials.keys)
        let values = Array(station.serials.values)
        
        guard values.count > 0 else {
            return cell!
        }

        cell?.lineLabel1?.text = values[0]
        cell?.lineLabel1?.textColor = UIColor.whiteColor()
        cell?.lineLabel1?.backgroundColor = cell?.colorMapping[keys[0]]
        cell?.lineLabel1?.layer.masksToBounds = true
        cell?.lineLabel1?.layer.cornerRadius = 4

        guard values.count > 1 else {
            cell?.lineLabel2?.hidden = true
            return cell!
        }
        
        cell?.lineLabel2?.text = values[1]
        cell?.lineLabel2?.textColor = UIColor.whiteColor()
        cell?.lineLabel2?.backgroundColor = cell?.colorMapping[keys[1]]
        cell?.lineLabel2?.layer.masksToBounds = true
        cell?.lineLabel2?.layer.cornerRadius = 4

        return cell!
    }
}

