//
//  MainViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/14.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabBarView: CustomTabBarView!
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var report: UIButton!
    @IBOutlet weak var log: UIButton!
    @IBOutlet weak var setting: UIButton!
    
    // MARK: - Variables
    
    var vc: [UIViewController] = []
    var historyVC = HistoryViewController()
    var bloodSugarCorrectionVC = BloodSugarCorrectionViewController()
    var instanceBloodSugarVC = InstanceBloodSugarViewController()
    var lifeStyleVC = LifeStyleViewController()
    var persionalInformationVC = PersionalInformationViewController()
    var selectStatus: Bool = false
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = [historyVC, bloodSugarCorrectionVC, instanceBloodSugarVC, lifeStyleVC, persionalInformationVC]
        
        
        
        updateView(index: 2)
        
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        tabBarView.onItemsTapped = {
            self.updateView(index: $0)
        }
        setNavigationBar()
        
    }
    
    func updateView(index: Int) {
        // 會逐個掃描，並把 vc 裡 children 沒有的 view 放進 children 裡
        if children.first(where: { String(describing: $0.classForCoder) == String(describing: vc[index].classForCoder) }) == nil {
            addChild(vc[index])
            vc[index].view.frame = containerView.bounds
        }
        navigationItem.title = tabBarView.vcTitleArray[index]
        containerView.addSubview(vc[index].view)
    }
    
    func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        // 將三條線的 LeftBarButtonItem 格式設定好
        // 建立一個 Button 然後再將他放到 View 裡
        let buttonItem = UIButton(type: .custom)
        buttonItem.setImage(UIImage(named: "ThreeLineSmall"), for: .normal)
        buttonItem.setTitle("", for: .normal)
        buttonItem.addTarget(self, action: #selector(tapLeftBarButtonItem), for: .touchUpInside)
        let buttonView = UIBarButtonItem(customView: buttonItem)
        // 設定寬
        let currWidth = buttonView.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        // 設定高
        let currHeight = buttonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        
        self.navigationItem.leftBarButtonItem = buttonView
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                    target: nil, action: nil)
        //把設定好的 View 放進 Navigation 裏面
        navigationItem.leftBarButtonItems = [buttonView]
        setNavigationbar(backgroundcolor: .navigationBar!)
        
    }

    // MARK: - IBAction
    
    @objc func tapLeftBarButtonItem() {
        selectStatus.toggle()
        DispatchQueue.main.async {
            if self.selectStatus == true {
                UIView.animate(withDuration: 0.5) {
                    self.optionView.transform = CGAffineTransform(translationX: 145, y: 0)
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.optionView.transform = CGAffineTransform(translationX: -145, y: 0)
                }
            }
           
        }
    }
    
    
    
    // MARK: - onItemsTapped
    //
    private func onItemsTapped(index: Int) {
        updateView(index: index)
    }
    
}

// MARK: - Protocol

