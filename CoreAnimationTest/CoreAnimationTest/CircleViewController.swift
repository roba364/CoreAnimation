//
//  CircleViewController.swift
//  CoreAnimationTest
//
//  Created by SofiaBuslavskaya on 07/05/2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit

import UIKit

class CircleViewController: UIViewController, URLSessionDownloadDelegate {
    
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .NSExtensionHostWillEnterForeground, object: nil)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backGroundColor
        
        // Condition observer
        
        setupNotificationObservers()
        
        // drawing layers
        
        setupCircleLayers()
        
        // gesture

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        // percentage label
        
        setupPercentageLabel()
    }
    
    //MARK: - Selector
    
    @objc private func handleTap() {
        beginDownloadingFile()
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    //MARK: - Drawing circle
    
    private func setupCircleLayers() {
        // let's start by drawing a circle
        
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear,
                                                lineWidth: 10,
                                                fillColor: .pulsatingFillColor)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        // tracking layer
        
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor,
                                                lineWidth: 20,
                                                fillColor: .backGroundColor)
        view.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor,
                                            lineWidth: 20,
                                            fillColor: .clear)
        shapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.position = view.center
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }

    
    //MARK: - Downloading file
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    private func beginDownloadingFile() {
        print("Attempting to download file")
        
        shapeLayer.strokeEnd = 0
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    // metod for checking downloading statistic
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        
        print(percentage)
    }
    
    // method to track downloadTask
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    //MARK: - Animation
    
    private func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    private func animatePulsatingLayer() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsating")
    }
    
    //MARK: - Helper functions
    
    private func createCircleShapeLayer(strokeColor: UIColor,
                                        lineWidth: CGFloat,
                                        fillColor: UIColor) -> CAShapeLayer {
        
        let layer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.position = view.center
        
        return layer
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
}
