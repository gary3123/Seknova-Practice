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
        
    }
    
    func catchQRcode () {
        // 啟動相機
        AVCsession.startRunning()
        
        //取的預設的相機裝置（後鏡頭）
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
            qrCodeView.layer.borderWidth = 5
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
            catchQRcode()
            
        }else {
            
        }
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
                    self.AVCsession.stopRunning()
                    print(stringValue)
                }
            }
        }
        
    }
    
}


// MARK: - Protocol


