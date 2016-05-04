//
//  ViewController.swift
//  MRTStationList
//
//  Created by 吳恒毅 on 2016/5/3.
//  Copyright © 2016年 Heng-Yi Wu. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let CELL_REUSE_IDENTIFIER = "mrt_station"

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
        var cell = self.tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_IDENTIFIER)

        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CELL_REUSE_IDENTIFIER)
        }
        
        let title: String = lineTitles[indexPath.section]

        let line: MRTStationLine = lines[title]!
        let station: MRTStation = line.stations[indexPath.row]
        cell?.textLabel?.text = station.name

        return cell!
    }
}

