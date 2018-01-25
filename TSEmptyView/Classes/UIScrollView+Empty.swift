//
//  UIScrollView+Empty.swift
//  TSEmptyView
//
//  Created by 李棠松 on 2018/1/24.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit
extension UIScrollView{
    fileprivate struct AssociatedKeys{
        static var ts_emptyView: TSEmptyView?
    }
    
    open var ts_emptyView: TSEmptyView?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.ts_emptyView) as? TSEmptyView
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.ts_emptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            for view in self.subviews{
                if view.isKind(of: TSEmptyView.self){
                    view.removeFromSuperview()
                }
            }
            if newValue != nil{
                addSubview(newValue!)
            }
        }
    }
    
    var totalDataCount: Int{
        var totalCount = 0
        if self.isKind(of: UITableView.self) {
            for i in 0..<(self as! UITableView).numberOfSections{
                totalCount += (self as! UITableView).numberOfRows(inSection: i)
            }
        }else if self.isKind(of: UICollectionView.self){
            for i in 0..<(self as! UICollectionView).numberOfSections{
                totalCount += (self as! UICollectionView).numberOfItems(inSection: i)
            }
        }
        return totalCount
    }
    func getDataAndSet(){
        if totalDataCount == 0 {
            show()
        }else{
            hide()
        }
    }
    open func show(){
        if ts_emptyView?.isAutoShowEmptyView != true {
            self.ts_emptyView?.isHidden = false
            return
        }
        ts_showEmptyView()
    }
    open func hide(){
        if ts_emptyView?.isAutoShowEmptyView != true {
            self.ts_emptyView?.isHidden = true
            return
        }
        ts_hideEmptyView()
    }
    
    open func ts_showEmptyView(){
        ts_emptyView?.superview?.layoutSubviews()
        ts_emptyView?.isHidden = false
        if ts_emptyView != nil {
            bringSubview(toFront: ts_emptyView!)
        }
    }
    open func ts_hideEmptyView(){
        self.ts_emptyView?.isHidden = true
    }
    
    static func swizzle(originalSelector: Selector, to swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!);
        }
    }
}
extension UITableView{
    static func tableViewSwizzle(){
        swizzle(originalSelector: #selector(reloadData), to: #selector(ts_reloadData))
        swizzle(originalSelector: #selector(insertSections(_:with:)), to: #selector(ts_insertSections(_:with:)))
        swizzle(originalSelector: #selector(deleteSections(_:with:)), to: #selector(ts_deleteSections(_:with:)))
        swizzle(originalSelector: #selector(insertRows(at:with:)), to: #selector(ts_insertRows(at:with:)))
        swizzle(originalSelector: #selector(deleteRows(at:with:)), to: #selector(ts_deleteRows(at:with:)))
    }
    
    @objc func ts_reloadData(){
        ts_reloadData()
        getDataAndSet()
    }
    @objc func ts_insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
        ts_insertSections(sections, with: animation)
        getDataAndSet()
    }
    
    @objc func ts_insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
        ts_insertRows(at: indexPaths, with: animation)
        getDataAndSet()
    }
    
    @objc func ts_deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
        ts_deleteSections(sections, with: animation)
        getDataAndSet()
    }
    
    @objc func ts_deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
        ts_deleteRows(at: indexPaths, with: animation)
        getDataAndSet()
    }
    
   
    
}

extension UICollectionView{
//    private static let onceToken = UUID().uuidString
    static func collectionViewSwizzle(){
        swizzle(originalSelector: #selector(reloadData), to: #selector(ts_reloadData))
        swizzle(originalSelector: #selector(insertSections(_:)), to: #selector(ts_insertSections(_:)))
        swizzle(originalSelector: #selector(insertItems(at:)), to: #selector(ts_insertItems(at:)))
        swizzle(originalSelector: #selector(deleteItems(at:)), to: #selector(ts_deleteItems(at:)))
        swizzle(originalSelector: #selector(deleteSections(_:)), to: #selector(ts_deleteSections(_:)))
    }
    @objc func ts_reloadData(){
        ts_reloadData()
        getDataAndSet()
    }
    @objc func ts_insertSections(_ sections: IndexSet){
        ts_insertSections(sections)
        getDataAndSet()
    }
    
    @objc func ts_deleteSections(_ sections: IndexSet){
        ts_deleteSections(sections)
        getDataAndSet()
    }
    
    @objc func ts_insertItems(at indexPaths: [IndexPath]){
        ts_insertItems(at: indexPaths)
        getDataAndSet()
    }
    
    @objc func ts_deleteItems(at indexPaths: [IndexPath]){
        ts_deleteItems(at: indexPaths)
        getDataAndSet()
    }

    
}


