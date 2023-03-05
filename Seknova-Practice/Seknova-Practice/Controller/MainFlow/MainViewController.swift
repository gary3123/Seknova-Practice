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
    var content: ContentPage = .instanceBloodSugar
    var buttonView = UIBarButtonItem() // 三條線
    var sensorView = UIBarButtonItem() // Sensor 狀態，迴紋針
    var deviceButtonView = UIBarButtonItem() // 電池圖
    var updateButtonView = UIBarButtonItem() // 更新
    var reloadChartViewButton = UIButton() // 更新歷史紀錄頁面的 ChartView
    var connectStatus: Bool = false
    
    enum ContentPage {
        case history
        case bloodSugarCorrection
        case instanceBloodSugar
        case lifeStyle
        case persionalInformation
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = [historyVC, bloodSugarCorrectionVC, instanceBloodSugarVC, lifeStyleVC, persionalInformationVC]
        
        // 預設進來的頁面是第 3 頁
        updateView(index: 2)
        
        // 建立 Notification 接收者
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(completeBloodSugarCorrection),
                                               name: .goInstanceBloodSugarVC,
                                               object: nil)
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setNavigationBar()
        tabBarView.onItemsTapped = {
            self.updateView(index: $0) // $0 從第一個開始掃描
        }
    }
    
    func updateView(index: Int) {
        // 會逐個掃描，並把 vc 裡 children 沒有的 view 放進 children 裡
        if children.first(where: { String(describing: $0.classForCoder) == String(describing: vc[index].classForCoder) }) == nil {
            addChild(vc[index])
            vc[index].view.frame = containerView.bounds
        }
        navigationItem.title = tabBarView.vcTitleArray[index]
        // 將中間的 container 替換成閉包, delegate 帶進來的值
        containerView.addSubview(vc[index].view)
        setMainBarButtonItem()
        navigationItem.setRightBarButtonItems(nil, animated: true)
        if index == 4 {
            setupdateButtonItem()
        } else if index == 3 {
            setupEeventRecordButtonItem()
        } else if index == 2 {
            setBatteryButtonItem()
        } else if index == 0 {
            setupReloadHistoryChartViewDataButton()
            navigationItem.backButtonTitle = ""
        }
    }
    
    func setNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: false)
        setNavigationbar(backgroundcolor: .navigationBar!)
    }
    
    func  setupReloadHistoryChartViewDataButton() {
        reloadChartViewButton = UIButton(type: .custom)
        reloadChartViewButton.setImage(UIImage(named: "reload"), for: .normal)
        reloadChartViewButton.addTarget(self, action: #selector(reloadHistoryChartView), for: .touchUpInside)
        let reloadChartViewButtonView = UIBarButtonItem(customView: reloadChartViewButton)
        // 設定寬
        let reloadChartViewButtonViewWidth = reloadChartViewButtonView.customView?.widthAnchor.constraint(equalToConstant: 24)
        reloadChartViewButtonViewWidth!.isActive = true
        // 設定高
        let reloadChartViewButtonViewHeight = reloadChartViewButtonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        reloadChartViewButtonViewHeight!.isActive = true
        navigationItem.rightBarButtonItem = reloadChartViewButtonView
    }
    
    func setMainBarButtonItem() {
        // 將三條線的 LeftBarButtonItem 格式設定好
        // 建立一個 Button 然後再將他放到 View 裡
        let buttonItem = UIButton(type: .custom)
        buttonItem.setImage(UIImage(named: "ThreeLineSmall"), for: .normal)
        buttonItem.setTitle("", for: .normal)
        buttonItem.addTarget(self, action: #selector(callOptionView), for: .touchUpInside)
        buttonView = UIBarButtonItem(customView: buttonItem)
        // 設定寬
        let buttonViewWidth = buttonView.customView?.widthAnchor.constraint(equalToConstant: 24)
        buttonViewWidth?.isActive = true
        // 設定高
        let buttonViewHeight = buttonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        buttonViewHeight?.isActive = true
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        space.width = 10
        
        if UserPreferences.shared.sensorID != "" && UserPreferences.shared.deviceID != "" {
            connectStatus = true
        }
        let sensorItem = UIButton(type: .custom)
        sensorItem.setImage(UIImage(named: connectStatus ? "link" : "unlink"), for: .normal)
        sensorItem.setTitle("", for: .normal)
        sensorItem.addTarget(self, action: #selector(connectPopover), for: .touchUpInside)
        sensorView = UIBarButtonItem(customView: sensorItem)
        // 設定寬
        let sensorViewWidth = sensorView.customView?.widthAnchor.constraint(equalToConstant: 24)
        sensorViewWidth?.isActive = true
        // 設定高
        let sensorViewHeight = sensorView.customView?.heightAnchor.constraint(equalToConstant: 24)
        sensorViewHeight?.isActive = true
        
        // 把設定好的 View 放進 Navigation 裏面
        navigationItem.leftBarButtonItems = [buttonView, space, sensorView]
    }
    
    //設定裝置電量以及感測器電量的 barButtonItem
    func setBatteryButtonItem() {
        let deviceButtonItem = UIView()
        DispatchQueue.main.async {
            CommandBase.sharedInstance.drawCircle(in: deviceButtonItem)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(callTimeAndBattery))
        tap.numberOfTapsRequired = 1
        deviceButtonItem.addGestureRecognizer(tap)
        deviceButtonView = UIBarButtonItem(customView: deviceButtonItem)
        // 設定寬
        let deviceButtonViewWidth = deviceButtonView.customView?.widthAnchor.constraint(equalToConstant: 55)
        deviceButtonViewWidth?.isActive = true
        // 設定高
        let deviceButtonViewHeight = deviceButtonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        deviceButtonViewHeight?.isActive = true
        navigationItem.rightBarButtonItem = deviceButtonView
    }
    
    func setupdateButtonItem() {
        let updateButtonItem = UIButton(type: .custom)
        updateButtonItem.setTitle("更新", for: .normal)
        updateButtonItem.addTarget(self, action: #selector(updatePersionalInformation), for: .touchUpInside)
        updateButtonView = UIBarButtonItem(customView: updateButtonItem)
        // 設定寬
        let updateButtonViewWidth = updateButtonView.customView?.widthAnchor.constraint(equalToConstant: 50)
        updateButtonViewWidth?.isActive = true
        // 設定高
        let updateButtonViewHeight = updateButtonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        updateButtonViewHeight?.isActive = true
        navigationItem.rightBarButtonItem = updateButtonView
    }
    
    func setupEeventRecordButtonItem() {
        let updateButtonItem = UIButton(type: .custom)
        updateButtonItem.setTitle("事件記錄", for: .normal)
        updateButtonItem.addTarget(self, action: #selector(clickEventRecordBarButtonItem), for: .touchUpInside)
        updateButtonView = UIBarButtonItem(customView: updateButtonItem)
        // 設定寬
        let updateButtonViewWidth = updateButtonView.customView?.widthAnchor.constraint(equalToConstant: 80)
        updateButtonViewWidth?.isActive = true
        // 設定高
        let updateButtonViewHeight = updateButtonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        updateButtonViewHeight?.isActive = true
        navigationItem.rightBarButtonItem = updateButtonView
    }
    
    
    // MARK: - completeBloodSugarCorrection
    
    @objc func completeBloodSugarCorrection() {
        updateView(index: 2)
    }
    
    // MARK: - callTimeAndBattery
    
    @objc func callTimeAndBattery() {
        let pop = TransmitterTimeAndSensorBatteryPopover()
        pop.modalPresentationStyle = .popover
        pop.modalPresentationStyle = .popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = deviceButtonView.customView!
        pop.popoverPresentationController?.sourceRect = CGRect(x: deviceButtonView.width + 40,
                                                               y: 30,
                                                               width: 0,
                                                               height: 0)
        pop.preferredContentSize = CGSize(width: pop.view.bounds.width, height: pop.view.bounds.height)
        present(pop, animated: true)
    }
    
    // MARK: - IBAction
    
    
    @objc func clickEventRecordBarButtonItem() {
        let nextVC = EventRecordViewController()
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func clickReportForm() {
        let nextVC = ReportFormViewController()
        navigationItem.backButtonTitle = "返回"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func clickSettingButton() {
        let nextVC = SettingViewController()
        navigationItem.backButtonTitle = "返回"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func clickLogsButton() {
        let nextVC = LogViewController()
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func updatePersionalInformation() {
        // 當按下更新 BarButtonItem 時 會呼叫 NotificationCenter 給 PersionalInformation 頁面接收
        NotificationCenter.default.post(name: .updatePersionalInformation, object: nil)
    }
    
    @objc func callOptionView() {
        selectStatus.toggle()
        DispatchQueue.main.async {
            if self.selectStatus == true {
                self.optionView.isHidden = false
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
    
    @objc func reloadHistoryChartView() {
        NotificationCenter.default.post(name: .reloadHistoryChartViewData, object: nil)
    }
    
    @objc func connectPopover() {
        let pop = ConnectPopoverViewController()
        pop.modalPresentationStyle = .popover
        pop.modalPresentationStyle = .popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = sensorView.customView!
        pop.popoverPresentationController?.sourceRect = CGRect(x: 12, y: 30, width: 0, height: 0)
        pop.preferredContentSize = CGSize(width: pop.view.bounds.width, height: pop.view.bounds.height)
        present(pop, animated: true)
    }
    
    
    // MARK: - onItemsTapped
    private func onItemsTapped(index: Int) {
        updateView(index: index)
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate

extension MainViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UIImage {
    class func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

// MARK: - Protocol


