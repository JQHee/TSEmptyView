//
//  ViewController.swift
//  TSEmptyView
//
//  Created by leetangsong on 01/25/2018.
//  Copyright (c) 2018 leetangsong. All rights reserved.
//

import UIKit
import TSEmptyView
class ViewController: UIViewController {
    var tableView: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 500))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
//        tableView.ts_emptyView = TSEmptyView.init(image: nil, title: "test", detail: "fasdfad", btnTitle: nil, btnAction: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

