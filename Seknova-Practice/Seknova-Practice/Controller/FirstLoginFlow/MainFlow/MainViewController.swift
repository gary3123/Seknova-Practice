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
    
    // MARK: - Variables
    
    var vc: [UIViewController] = []
    var historyVC = HistoryViewController()
    var bloodSugarCorrectionVC = BloodSugarCorrectionViewController()
    var instanceBloodSugarVC = InstanceBloodSugarViewController()
    var lifeStyleVC = LifeStyleViewController()
    var persionalInformationVC = PersionalInformationViewController()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = [historyVC, bloodSugarCorrectionVC, instanceBloodSugarVC, lifeStyleVC, persionalInformationVC]
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        
        setNavigationbar(backgroundcolor: .navigationBar!)
        
        updateView(index: 2)
        
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        tabBarView.onItemsTapped = {
            self.updateView(index: $0)
        }
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
    
    

    // MARK: - IBAction
    
    
    
    // MARK: - onItemsTapped
    //
    private func onItemsTapped(index: Int) {
        updateView(index: index)
    }
    
}

// MARK: - Protocol

