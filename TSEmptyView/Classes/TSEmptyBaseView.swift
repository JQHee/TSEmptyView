//
//  TSEmptyBaseView.swift
//  TSEmptyView
//
//  Created by 李棠松 on 2018/1/24.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit

open class TSEmptyBaseView: UIView {
    lazy var contentView: UIView = {
        let temp = UIView()
        self.addSubview(temp)
        return temp
    }()
    open var image: UIImage?{
        didSet{
            setupSubviews()
        }
    }
    open var title: String?{
        didSet{
            setupSubviews()
        }
    }
    open var detail: String?{
        didSet{
            setupSubviews()
        }
    }
    open var btnTitle: String?{
        didSet{
            setupSubviews()
        }
    }
    var tapContentViewAction: (()->Void)?
    
    private(set) var btnAction: (()->Void)?
    private(set) var actionBtnTarget: Any?
    private(set) var actionBtnAction: Selector?
    private(set) var customView: UIView?
    
    open var isAutoShowEmptyView: Bool = true
    
    /// 构造方法1 - 创建emptyView
    ///
    /// - Parameters:
    ///   - image: 占位图片
    ///   - title: 标题
    ///   - detail: 详细描述
    ///   - btnTitle: 按钮的名称
    ///   - target: 响应的对象
    ///   - action: 按钮点击事件
    public init(image: UIImage?,
                title: String?,
                detail: String?,
                btnTitle: String?,
                target: Any?,
                action:Selector) {
        TSEmptySwizzle.swizzle()
        self.image = image
        self.title = title
        self.detail = detail
        self.btnTitle = btnTitle
        self.actionBtnTarget = target
        self.actionBtnAction = action
        super.init(frame: .zero)
        self.prepare()
        creatEmptyView()
    }
    /// 构造方法2 - 创建emptyView
    ///
    /// - Parameters:
    ///   - image: 占位图片
    ///   - title: 标题
    ///   - detail: 详细描述
    ///   - btnTitle: 按钮的名称
    ///   - btnAction: 按钮点击事件回调
    public init(image: UIImage?,
                title: String?,
                detail: String?,
                btnTitle: String?,
                btnAction: (()->Void)?) {
        TSEmptySwizzle.swizzle()
        self.image = image
        self.title = title
        self.detail = detail
        self.btnTitle = btnTitle
        self.btnAction = btnAction
        super.init(frame: .zero)
        prepare()
        creatEmptyView()
    }
    
    public init(customView: UIView) {
        TSEmptySwizzle.swizzle()
        self.customView = customView
        super.init(frame: .zero)
        prepare()
        contentView.addSubview(customView)
    }
    
    
    open func prepare(){
        self.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let view = superview,view.isKind(of: UIScrollView.self){
            self.ts_width = view.ts_width
            self.ts_height = view.ts_height
        }
        setupSubviews()
    }
    
    open func setupSubviews(){
        
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let newSuperview = newSuperview,newSuperview.isKind(of: UIScrollView.self) {
            self.ts_width = newSuperview.ts_width
            self.ts_height = newSuperview.ts_height
        }
    }
    
    private func creatEmptyView(){
        contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapContentView)))
    }
    
    
    
    @objc func tapContentView(){
        tapContentViewAction?()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
