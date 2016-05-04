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
    var data:[MRTStation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchList() {
        _ = stationList.fetch()
            .subscribeNext { stations in
                self.data.removeAll()
                for station in stations {
                    self.data.append(station)
                }
                self.tableView.reloadData()
            }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_IDENTIFIER)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: CELL_REUSE_IDENTIFIER)
        }
        cell?.textLabel?.text = data[indexPath.row].name
        return cell!
    }
}

