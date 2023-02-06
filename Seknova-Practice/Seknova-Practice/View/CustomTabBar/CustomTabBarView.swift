//
//  CustomTabBarView.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/13.
//

import UIKit

class CustomTabBarView: UIView {

    // MARK: - IBOutlet
    // 將需要繼承剛剛建立客製化按鈕的 class 宣告
    @IBOutlet weak var history: ImageButtonView!
    @IBOutlet weak var bloodSugarCorrection: ImageButtonView!
    @IBOutlet weak var instanceBloodSugar: ImageButtonView!
    @IBOutlet weak var lifeStyle: ImageButtonView!
    @IBOutlet weak var persionalInformation: ImageButtonView!

    // MARK: - Variables
    
    var onItemsTapped: ((Int) -> ())? = nil
    
    var vcTitleArray: [String] = ["歷史紀錄", "血糖校正", "即時血糖", "生活作息", "個人資訊"]
    
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
    // 呼叫 ImageButtonView 的初始化 func
    func setInit() {
        history.setInit(imageName: "history",
                        labelText: vcTitleArray[0],
                        index: 0,
                        delegate: self)
        
        bloodSugarCorrection.setInit(imageName: "blood-1",
                                     labelText: vcTitleArray[1],
                                     index: 1,
                                     delegate: self)
        
        instanceBloodSugar.setInit(imageName: "trend",
                                   labelText: vcTitleArray[2],
                                   index: 2,
                                   delegate: self)
        
        lifeStyle.setInit(imageName: "calendar-1",
                          labelText: vcTitleArray[3],
                          index: 3,
                          delegate: self)
        
        persionalInformation.setInit(imageName: "user",
                                     labelText: vcTitleArray[4],
                                     index: 4,
                                     delegate: self)
    }
    
    
    // MARK: - IBAction
}

// MARK: - Extensions

fileprivate extension CustomTabBarView {
    // 加入畫面
    func addXibView() {
        if let loadView = Bundle(for: CustomTabBarView.self)
            .loadNibNamed("CustomTabBarView",
                          owner: self,
                          options: nil)?.first as? UIView {
            addSubview(loadView)
            loadView.frame = bounds
            setInit()
        }
    }
}

// MARK: - CustomFavoriteButtonDelegate

extension CustomTabBarView: ImageButtonViewDelegate {
    
    // 把點選的值放進 onItemsTapped 閉包中
    func imageButtonView(didClickAt index: Int) {
        onItemsTapped?(index)
    }
}

// MARK: - Protocol


