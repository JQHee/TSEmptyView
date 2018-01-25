//
//  TSEmptyView.swift
//  TSEmptyView
//
//  Created by 李棠松 on 2018/1/24.
//  Copyright © 2018年 李棠松. All rights reserved.
//

import UIKit

open class TSEmptyView: TSEmptyBaseView {
    ///每个子控件之间的间距 default is 15.f
    public var subViewMargin: CGFloat = 15{
        didSet{
            setupSubviews()
        }
    }
    ///垂直方向偏移 (此属性与contentViewY 互斥，只有一个会有效)
    public var contentViewOffset: CGFloat = 0{
        didSet{
            self.ts_y += contentViewOffset
        }
    }
    ///Y坐标 (此属性与contentViewOffset 互斥，只有一个会有效)
    public var contentViewY: CGFloat = 1000{
        didSet{
            self.ts_y = contentViewY
        }
    }
    ///图片可设置固定大小 (default=图片实际大小)
    public var imageSize: CGSize?{
        didSet{
            setupSubviews()
        }
    }
    ///标题字体, 大小default is 16.f
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 16){
        didSet{
            setupSubviews()
        }
    }
    ///标题文字颜色 default UIColor.darkText
    public var titleTextColor: UIColor = UIColor.darkText{
        didSet{
            titleLabel.textColor = titleTextColor
        }
    }
    ///详细描述字体大小 default  14
    public var detailFont: UIFont = UIFont.systemFont(ofSize: 14){
        didSet{
            setupSubviews()
        }
    }
    ///详细描述字体颜色 default UIColor.lightText
    public var detailTextColor: UIColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1){
        didSet{
            detailLabel.textColor = detailTextColor
        }
    }
    ///按钮字体大小 default  14
    public var btnFont: UIFont = UIFont.systemFont(ofSize: 14){
        didSet{
            setupSubviews()
        }
    }
    ///按钮高度 default 40
    public var btnHeight: CGFloat = 40{
        didSet{
            setupSubviews()
        }
    }
    ///水平方向内边距 default  30
    public var btnHorizontalMargin: CGFloat = 30{
        didSet{
            setupSubviews()
        }
    }
    ///按钮的圆角大小, default  5
    public var btnCornerRadius: CGFloat = 5{
        didSet{
            actionButton.layer.cornerRadius = btnCornerRadius
        }
    }
    ///按钮边框border的宽度 default 0
    public var btnBorderWidth: CGFloat = 0{
        didSet{
            actionButton.layer.borderWidth = btnBorderWidth
        }
    }
    ///按钮边框颜色 default clear
    public var btnBorderColor: UIColor = .clear{
        didSet{
            actionButton.layer.borderColor = btnBorderColor.cgColor
        }
    }
    ///按钮文字颜色 default darkText
    public var btnTitleColor: UIColor = .darkText{
        didSet{
            actionButton.setTitleColor(btnTitleColor, for: .normal)
        }
    }
    ///按钮背景颜色
    public var btnBackgroundColor: UIColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1){
        didSet{
            actionButton.backgroundColor = btnBackgroundColor
        }
    }
    
    
    open lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFit
        self.contentView.addSubview(temp)
        return temp
    }()
    open lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        self.contentView.addSubview(temp)
        return temp
    }()
    open lazy var detailLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.numberOfLines = 2
        self.contentView.addSubview(temp)
        return temp
    }()
    open lazy var actionButton: UIButton = {
        let temp = UIButton()
        temp.layer.masksToBounds = true
        self.contentView.addSubview(temp)
        return temp
    }()
    private var contentMaxWidth: CGFloat = 0 //最大宽度
    private var contentWidth: CGFloat = 0    //内容物宽度
    private var contentHeight: CGFloat = 0   //内容物高度
    
    
    override open func setupSubviews() {
        super.setupSubviews()
        contentMaxWidth = self.ts_width-30
        if  let image = image {
            setupImageView(image: image)
        }else{
            imageView.removeFromSuperview()
        }
        
        if let title = self.title ,title.count>0{
            setupTitleLabel(titleStr: title)
            contentView.addSubview(titleLabel)
        }else{
            titleLabel.removeFromSuperview()
        }
        
        if let detail = self.detail,detail.count>0 {
            contentView.addSubview(detailLabel)
            setupDetailLabel(detailStr: detail)
        }else{
            detailLabel.removeFromSuperview()
        }
        
        if let btnTitle = self.btnTitle,btnTitle.count>0{
            if let target = self.actionBtnTarget, let action = self.actionBtnAction {
                setupActionBtn(btnTitle: btnTitle,
                               target: target,
                               action: action,
                               btnClickAction: nil)
            }else if let action = self.btnAction{
                setupActionBtn(btnTitle: btnTitle,
                               target: nil,
                               action: nil,
                               btnClickAction: action)
            }else{
                actionButton.removeFromSuperview()
            }
        }else{
            actionButton.removeFromSuperview()
        }
        
        if let customView = self.customView {
            contentWidth = customView.ts_width
            contentHeight = customView.ts_maxY
        }
        setSubViewFrame()
    }
    
    private func setSubViewFrame(){
        //获取self原始宽高
        let scrollViewWidth = self.bounds.size.width
        let scrollViewHeight = self.bounds.size.height
        //重新设置self的frame（大小为content的大小）
        self.ts_size = CGSize.init(width: contentWidth, height: contentHeight)
        let emptyViewCenterX = scrollViewWidth * 0.5
        let emptyViewCenterY = scrollViewHeight * 0.5
        self.center = CGPoint.init(x: emptyViewCenterX, y: emptyViewCenterY)
        
        contentView.frame = self.bounds
        
        //子控件的centerX设置
        let centerX = contentView.ts_width * 0.5
        
        self.customView?.ts_centerX = centerX
        imageView.ts_centerX = centerX
        titleLabel.ts_centerX = centerX
        detailLabel.ts_centerX = centerX
        actionButton.ts_centerX = centerX
        
        if contentViewOffset>0{
            self.ts_centerY += contentViewOffset
        }
        if contentViewY < 1000 {
            self.ts_y = contentViewY
        }
    }
    
    private func setupImageView(image: UIImage){
        imageView.image = image
        var imageViewWidth = image.size.width
        var imageViewHeight = image.size.height
        if let imageSize = self.imageSize{
            if imageViewWidth>imageViewHeight{
                imageViewHeight = (imageViewHeight / imageViewWidth) * imageSize.width
                imageViewWidth = imageSize.width
            }else{
                imageViewWidth = (imageViewWidth / imageViewHeight) * imageSize.height
                imageViewHeight = imageSize.height
            }
        }
        
        imageView.frame = CGRect.init(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)
        contentWidth = imageViewWidth
        contentHeight = imageView.ts_maxY
    }
    
    private func setupTitleLabel(titleStr: String){
        titleLabel.font = titleFont
        titleLabel.textColor = titleTextColor
        titleLabel.text = titleStr
        let size = titleLabel.sizeThatFits(CGSize.init(width: contentMaxWidth, height: titleFont.pointSize))
        titleLabel.frame = CGRect.init(x: 0, y: contentHeight+subViewMargin, width: size.width, height: titleFont.pointSize)
        contentWidth = size.width > contentWidth ? size.width : contentWidth
        contentHeight = self.titleLabel.ts_maxY
    }
    private func setupDetailLabel(detailStr: String){
        detailLabel.font = detailFont
        detailLabel.textColor = detailTextColor
        detailLabel.text = detailStr
        let size = detailLabel.sizeThatFits(CGSize.init(width: contentMaxWidth, height: detailFont.pointSize))
        detailLabel.frame = CGRect.init(x: 0, y: contentHeight + subViewMargin, width: size.width, height: detailFont.pointSize)
        contentWidth = size.width > contentWidth ? size.width : contentWidth
        contentHeight = self.detailLabel.ts_maxY
    }
    private func setupActionBtn(btnTitle: String,
                                target: Any?,
                                action: Selector?,
                                btnClickAction:(()->Void)?){
        actionButton.setTitle(btnTitle, for: .normal)
        actionButton.setTitleColor(btnTitleColor, for: .normal)
        actionButton.titleLabel?.font = btnFont
        actionButton.backgroundColor = btnBackgroundColor
        actionButton.layer.borderColor = btnBorderColor.cgColor
        actionButton.layer.borderWidth = btnBorderWidth
        actionButton.layer.cornerRadius = btnCornerRadius
        var height = btnHeight
        let size = actionButton.titleLabel!.sizeThatFits(CGSize.init(width: contentMaxWidth, height: btnFont.pointSize))
        
        if height < size.height{
            height = size.height + 4
        }
        var buttonWidth = size.width + btnHorizontalMargin
        buttonWidth = buttonWidth > contentMaxWidth ? contentMaxWidth : buttonWidth
        actionButton.frame = CGRect.init(x: 0, y: contentHeight + subViewMargin, width: buttonWidth, height: height)
        if target != nil && action != nil{
            actionButton.addTarget(target, action: action!, for: .touchUpOutside)
        }else if btnClickAction != nil{
            actionButton.addTarget(self, action: #selector(actionBtnClick), for: .touchUpInside)
        }
        contentWidth = buttonWidth > contentWidth ? buttonWidth : contentWidth
        contentHeight = actionButton.ts_maxY
        contentView.addSubview(actionButton)
    }
    
    @objc func actionBtnClick(){
        btnAction?()
    }
    
}
