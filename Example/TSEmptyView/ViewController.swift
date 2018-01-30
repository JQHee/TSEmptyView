//
//  ViewController.swift
//  TSEmptyView
//
//  Created by leetangsong on 01/25/2018.
//  Copyright (c) 2018 leetangsong. All rights reserved.
//

import UIKit
//import TSEmptyView
class ViewController: UIViewController,UITableViewDataSource {
    var tableView: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 500))
    var rows: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
//        tableView.ts_emptyView = TSEmptyView.init(image: #imageLiteral(resourceName: "empty"), title: "没有数据", detail: "发的房间防守打法", btnTitle: "设计", btnAction: {
//            self.rows = 1
//            self.tableView.reloadData()
//        })
        tableView.ts_startLoading()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

