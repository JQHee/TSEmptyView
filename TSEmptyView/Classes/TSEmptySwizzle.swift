//
//  TSEmptySwizzle.swift
//  TSEmptyView
//
//  Created by 李棠松 on 2018/1/24.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit

public final class TSEmptySwizzle: NSObject {
    public static func swizzle(){
        UITableView.tableViewSwizzle()
        UICollectionView.collectionViewSwizzle()
    }
}
