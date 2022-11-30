//
//  TransmitterContentViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/26.
//

import UIKit
import AVFoundation

class TransmitterContentViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var transmitterImageView: UIImageView!
    @IBOutlet weak var transmitterBImageView: UIImageView!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var qrCodeButton: UIButton!
    @IBOutlet weak var textInputButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Variables
    var AVCsession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeStatus = false
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Scanning Transmitter"
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setQRcode()
    }
    
    func setQRcode() {
        
        //取得預設的相機裝置（後鏡頭）
        let AVCdevice = AVCaptureDevice.default(for: .video)
        do {
            // 設定資料來源為後鏡頭
            let videoInput = try AVCaptureDeviceInput(device: AVCdevice!)
            AVCsession.addInput(videoInput)
            
            //設定取得資料為 Matadata 物件資料
            let AVCvideoOuput = AVCaptureMetadataOutput()
            AVCsession.addOutput(AVCvideoOuput)
            
            //接收所有 Metadata 資料
            AVCvideoOuput.metadataObjectTypes = [.qr]
            AVCvideoOuput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            //設定瀏覽畫面
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: AVCsession)
            videoPreviewLayer?.frame.size = qrCodeView.frame.size
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            qrCodeView.layer.addSublayer(videoPreviewLayer!)
            qrCodeView.layer.borderWidth = 2
            qrCodeView.layer.borderColor = UIColor.navigationBar?.cgColor
        
        } catch {
            print("error")
        }
        
    }
    
    
    // MARK: - IBAction
    @IBAction func clickQRCodeButton(_ sender: Any) {
        qrCodeStatus = !(qrCodeStatus)
        if qrCodeStatus == true {
            transmitterImageView.isHidden = true
            transmitterBImageView.isHidden = true
            qrCodeView.isHidden = false
            AVCsession.startRunning()
            
        }else {
            self.AVCsession.stopRunning()
            transmitterImageView.isHidden = false
            transmitterBImageView.isHidden = false
            qrCodeView.isHidden = true
        }
    }
    
    @IBAction func clickTextInput(_ sender: Any) {
        Alert.showTextField(title: "文字輸入",
                            message: "請輸入裝置ID",
                            vc: self,
                            confirmtitle: "確認",
                            canceltitle: "取消") { textField in
            // UITextField 樣式設定
            textField.delegate = self
            textField.keyboardType = .asciiCapable
            // 設定鍵盤第一個字大寫
            textField.autocapitalizationType = UITextAutocapitalizationType.words
            textField.placeholder = "輸入裝置 ID 後兩碼"
        } confirm: { textField in
            // 按下確認後要做的事
            guard let text = textField.text else { return }
            if text.validate(type: .deviceID) {
                UserPreferences.shared.deviceID = textField.text!
                let pairBlueToothVC = PairBlueToothViewController()
                self.navigationController?.pushViewController(pairBlueToothVC, animated: true)
            } else {
                Alert.showAlertWith(title: "輸入裝置 ID 格式錯誤",
                                    message: "輸入格式錯誤，請重新輸入",
                                    vc: self,
                                    confirmTitle: "確認")
            }
            
            
        }
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
    }
    
    
}

// MARK: - Extensions

extension TransmitterContentViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        if metadataObjects.isEmpty  {
            qrCodeView.frame = .zero
            return
        }
        
        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                
                //倘若發現的原資料與 QR code 原資料相同，便更新狀態標籤的文字並設定邊界
                if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj) {
                    qrCodeView?.frame = barCodeObject.bounds
                    guard let stringValue = metadataObj.stringValue else {
                        return
                    }
                    if stringValue.validate(type: .deviceID) {
                        print(stringValue)
                        UserPreferences.shared.deviceID = stringValue
                        let pairBlueToothVC = PairBlueToothViewController()
                        navigationController?.pushViewController(pairBlueToothVC, animated: true)
                    } else {
                        Alert.showAlertWith(title: "QR code 格式錯誤",
                                            message: "",
                                            vc: self,
                                            confirmTitle:"確認")
                    }
                   
                    
                }
            }
        }
        
    }
    
}


// MARK: - TextFieldDelegate

extension TransmitterContentViewController: UITextFieldDelegate {
    
    
    //判斷輸入的字數是否超過 6 是的話則不再進行輸入
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = textField.text!.count - range.length + string.count
        
        if countOfWords > 6 {
            return false
        }
        return true
    }
    
}


// MARK: - Protocol


