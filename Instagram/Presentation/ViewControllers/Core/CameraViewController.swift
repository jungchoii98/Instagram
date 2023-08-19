//
//  CameraViewController.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import AVFoundation
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func cameraViewControllerDidCapturePhoto(_ cameraViewController: CameraViewController, with image: UIImage)
}

class CameraViewController: UIViewController {
    
    private let previewView: PreviewView = {
        let view = PreviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        button.backgroundColor = .white
        return button
    }()
    
    weak var coordinator: CameraViewControllerDelegate?
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Camera"
        view.addSubview(previewView)
        view.addSubview(shutterButton)
        setUpNavigationBar()
        prepareAuthorization()
        shutterButton.addTarget(self, action: #selector(didTapShutter), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        startRunningCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopRunningCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let shutterButtonSize: CGFloat = view.width/5
        shutterButton.layer.cornerRadius = shutterButtonSize/2
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.heightAnchor.constraint(equalToConstant: view.width),
            
            shutterButton.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: 50),
            shutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shutterButton.heightAnchor.constraint(equalToConstant: view.width/5),
            shutterButton.widthAnchor.constraint(equalToConstant: view.width/5)
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
    
    @objc func didTapShutter() {
        photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
}

private extension CameraViewController {
    func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    func startRunningCamera() {
        DispatchQueue(label: "camera").async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopRunningCamera() {
        DispatchQueue(label: "camera").async {
            self.captureSession.stopRunning()
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data)
        else { return }
        stopRunningCamera()
        coordinator?.cameraViewControllerDidCapturePhoto(self, with: image)
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
