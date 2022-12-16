//
//  ImageButtonView.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/13.
//

import UIKit

class ImageButtonView: UIView {

    // MARK: - IBOutlet
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Variables
    
    var delegate: ImageButtonViewDelegate?
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        addXibView()
    }
    
    // view 在設計時想要看到畫面要用這個
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addXibView()
    }
    
    // MARK: - UI Settings
    
    /// ImageButtonView 客製化元件初始化
    /// - Parameters:
    ///   - imageName: 圖片名稱
    ///   - labelText: 按鈕名稱
    ///   - index: 按鈕標籤
    ///   - delegate: 讓呼叫這個 Func 的頁面傳值
    func setInit(imageName: String,
                 labelText: String,
                 index: Int,
                 delegate: ImageButtonViewDelegate) {
        imageView.image = UIImage(named: imageName)
        label.text = labelText
        button.setTitle("", for: .normal)
        button.tag = index
        self.delegate = delegate
    }
    
    // MARK: - IBAction
    
    @IBAction func btnClicked(_ sender: UIButton) {
        delegate?.imageButtonView(didClickAt: sender.tag)
    }
}

// MARK: - Extensions

fileprivate extension ImageButtonView {
    // 加入畫面
    func addXibView() {
        if let loadView = Bundle(for: ImageButtonView.self)
            .loadNibNamed("ImageButtonView",
                          owner: self,
                          options: nil)?.first as? UIView {
            addSubview(loadView)
            loadView.frame = bounds
        }
    }
}

// MARK: - Protocol

protocol ImageButtonViewDelegate {
    
    func imageButtonView(didClickAt index: Int)
}
