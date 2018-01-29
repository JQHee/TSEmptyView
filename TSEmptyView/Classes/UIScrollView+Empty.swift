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
        static var ts_loadView: UIView?
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
    open var ts_loadView: UIView?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.ts_emptyView) as? TSEmptyView ?? {
                let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
                view.layer.addSublayer(TSProgressLayer.init(frame: view.bounds))
                self.ts_loadView = view
                return view
                }()
        }
        set{
            if ts_loadView != nil{
                ts_loadView?.removeFromSuperview()
            }
            objc_setAssociatedObject(self, &AssociatedKeys.ts_emptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue != nil{
                addSubview(newValue!)
                newValue?.center = self.center
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
            self.ts_emptyView?.isHidden = true
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
        method_exchangeImplementations(originalMethod!, swizzledMethod!);
    }
    open func ts_startLoading(){
        self.ts_emptyView?.isHidden = true
        
    }
    open func ts_endLoading(){
        if totalDataCount == 0 {
             self.ts_emptyView?.isHidden = false
        }else{
             self.ts_emptyView?.isHidden = true
        }
    }
    
}
extension UITableView{
    private static let onceToken = UUID().uuidString
    static func tableViewSwizzle(){
        DispatchQueue.ts_once(token: onceToken)
        {
            swizzle(originalSelector: #selector(reloadData), to: #selector(ts_reloadData))
            swizzle(originalSelector: #selector(insertSections(_:with:)), to: #selector(ts_insertSections(_:with:)))
            swizzle(originalSelector: #selector(deleteSections(_:with:)), to: #selector(ts_deleteSections(_:with:)))
            swizzle(originalSelector: #selector(insertRows(at:with:)), to: #selector(ts_insertRows(at:with:)))
            swizzle(originalSelector: #selector(deleteRows(at:with:)), to: #selector(ts_deleteRows(at:with:)))
            
        }
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
    private static let onceToken = UUID().uuidString
    static func collectionViewSwizzle(){
        DispatchQueue.ts_once(token: onceToken)
        {
            
            swizzle(originalSelector: #selector(reloadData), to: #selector(ts_reloadData))
            swizzle(originalSelector: #selector(insertSections(_:)), to: #selector(ts_insertSections(_:)))
            swizzle(originalSelector: #selector(insertItems(at:)), to: #selector(ts_insertItems(at:)))
            swizzle(originalSelector: #selector(deleteItems(at:)), to: #selector(ts_deleteItems(at:)))
            swizzle(originalSelector: #selector(deleteSections(_:)), to: #selector(ts_deleteSections(_:)))
            
        }
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

extension DispatchQueue {
    
    private static var onceTracker = [String]()
    
    //Executes a block of code, associated with a unique token, only once.  The code is thread safe and will only execute the code once even in the presence of multithreaded calls.
    public class func ts_once(token: String, block: () -> Void)
    {   // 保证被 objc_sync_enter 和 objc_sync_exit 包裹的代码可以有序同步地执行
        objc_sync_enter(self)
        defer { // 作用域结束后执行defer中的代码
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}

