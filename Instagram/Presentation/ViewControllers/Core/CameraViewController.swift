//
//  CameraViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import AVFoundation
import UIKit

protocol CameraViewControllerDelegate: AnyObject {}

class CameraViewController: UIViewController {
    
    private var previewView: PreviewView = {
        let view = PreviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }()
    
    weak var coordinator: CameraViewControllerDelegate?
    private let captureSession = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Camera"
        view.addSubview(previewView)
        setUpNavigationBar()
        prepareAuthorization()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        DispatchQueue(label: "camera").async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue(label: "camera").async {
            self.captureSession.stopRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.heightAnchor.constraint(equalToConstant: view.width)
        ])
    }
    
    private func prepareAuthorization() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] isGranted in
                if isGranted {
                    DispatchQueue.main.async {
                        self?.configureCaptureSession()
                    }
                }
            }
        case .authorized:
            configureCaptureSession()
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
    }
    
    private func configureCaptureSession() {
        captureSession.beginConfiguration()
        
        guard let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified),
              let cameraDeviceInput = try? AVCaptureDeviceInput(device: cameraDevice),
              captureSession.canAddInput(cameraDeviceInput) else { return }
        captureSession.addInput(cameraDeviceInput)
        
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.addOutput(photoOutput)
        captureSession.sessionPreset = .photo
        
        captureSession.commitConfiguration()
        
        configurePreviewView()
    }
    
    private func configurePreviewView() {
        previewView.videoPreviewLayer.session = captureSession
    }
    
    @objc func didTapClose() {
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
}

private extension CameraViewController {
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
