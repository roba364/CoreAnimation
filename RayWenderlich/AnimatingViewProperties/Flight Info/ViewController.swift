

import UIKit
import QuartzCore


//MARK: ViewController
class ViewController: UIViewController {
  
  @IBOutlet var bgImageView: UIImageView!
  
  @IBOutlet var summaryIcon: UIImageView!
  @IBOutlet var summary: UILabel!
  
  @IBOutlet var flightNr: UILabel!
  @IBOutlet var gateNr: UILabel!
  @IBOutlet var departingFrom: UILabel!
  @IBOutlet var arrivingTo: UILabel!
  @IBOutlet var planeImage: UIImageView!
  
  @IBOutlet var flightStatus: UILabel!
  @IBOutlet var statusBanner: UIImageView!
  
  var snowView: SnowView!
  
  //MARK:- animations
  func fade(toImage: UIImage, showEffects: Bool) {
    // TODO: Create a crossfade animation for the background
    // Create & set up temp view
    
    let tempView = UIImageView(frame: bgImageView.frame)
    tempView.image = toImage
    tempView.alpha = 0.0
    tempView.center.y += 20
    tempView.bounds.size.width = bgImageView.bounds.width * 1.3
    bgImageView.superview?.insertSubview(tempView, aboveSubview: bgImageView)
    
    
    
    UIView.animate(withDuration: 0.5,
                   animations: {
                    // Fade temp view in
                    tempView.alpha = 1.0
                    tempView.center.y -= 20
                    tempView.bounds.size = self.bgImageView.bounds.size
                    
    }) { (_) in
            // Update background view & view temp view
        self.bgImageView.image = toImage
        tempView.removeFromSuperview()
    }
    //TODO: Create a fade animation for snowView
    
    UIView.animate(withDuration: 1.0,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
                    self.snowView.alpha = showEffects ? 1.0 : 0.0
    }, completion: nil)
  }
  
    func move(label: UILabel, text: String, offset: CGPoint) {
		//TODO: Animate a label's translation property
        // Create and set up temp label
        
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        tempLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        tempLabel.alpha = 0
        view.addSubview(tempLabel)
        
        // Fade out and translate real label
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
                        label.alpha = 0
        },
                       completion: nil)
        
        // Fade in and translate temp label
        UIView.animate(withDuration: 0.25,
                       delay: 0.2,
                       options: .curveEaseIn,
                       animations: {
                        tempLabel.transform = .identity
                        tempLabel.alpha = 1.0
        },
                       completion: { _ in
                        // Update real label and remove temp label
                        label.text = text
                        label.alpha = 1.0
                        label.transform = .identity
                        tempLabel.removeFromSuperview()
        })
        
        
  }
  
    func cubeTransition(label: UILabel, text: String) {
		//TODO: Create a faux rotating cube animation
        // Create and set up temp label
        let tempLabel = duplicateLabel(label: label)
        tempLabel.text = text
        let tempLabelOffset = label.frame.size.height / 2
        let scale = CGAffineTransform(scaleX: 1.0, y: 0.1)
        let translate = CGAffineTransform(translationX: 0.0, y: tempLabelOffset)
        tempLabel.transform = scale.concatenating(translate)
        label.superview?.addSubview(tempLabel)

        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        // Scale temp label down and translate up
                        
                        tempLabel.transform = .identity
                        
                        // Scale real label down and translate up
                        
                        label.transform = scale.concatenating(translate.inverted())
                        
        },
                       completion: { (_) in
                        // Update the real label's text and reset its transforms
                        label.text = tempLabel.text
                        label.transform = .identity
                        // Remove temp label
                        tempLabel.removeFromSuperview()
        })
        
        
  }

  
    func planeDepart() {
        //TODO: Animate the plane taking off and landing
        // Store the plane's center value
        let originalCenter = planeImage.center
        
        // Create a new frame animation
        UIView.animateKeyframes(withDuration: 1.5,
                                delay: 0.0,
                                animations: {
                                    // Create keyframes
                                    // Move plane right & up
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.0,
                                        relativeDuration: 0.25) {
                                            self.planeImage.center.x += 80
                                            self.planeImage.center.y -= 10
                                    }
                                    // Rotate plane
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.1,
                                        relativeDuration: 0.4) {
                                            self.planeImage.transform = CGAffineTransform(
                                                rotationAngle: -.pi / 8)
                                    }
                                    // Move plane right and up off screen, while fading out
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.25,
                                        relativeDuration: 0.25) {
                                            self.planeImage.center.x += 100
                                            self.planeImage.center.y -= 50
                                            self.planeImage.alpha = 0
                                    }
                                    // Move plane just off left side, reset transform and height
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.51,
                                        relativeDuration: 0.01) {
                                            self.planeImage.transform = .identity
                                            self.planeImage.center = CGPoint(
                                                x: 0.0,
                                                y: originalCenter.y)
                                    }
                                    // Move plane back to original position & fade in
                                    UIView.addKeyframe(
                                        withRelativeStartTime: 0.55,
                                        relativeDuration: 0.45) {
                                            self.planeImage.center = originalCenter
                                    }
        },
                                completion: nil)
    }
  
  func changeSummary(to summaryText: String) {
		//TODO: Animate the summary text
    
    UIView.animateKeyframes(withDuration: 1.0,
                            delay: 0.0,
                            animations: {
                                UIView.addKeyframe(
                                    withRelativeStartTime: 0.0,
                                    relativeDuration: 0.45) {
                                        self.summary.center.y -= 100.0
                                        
                                }
                                UIView.addKeyframe(
                                    withRelativeStartTime: 0.5,
                                    relativeDuration: 0.45) {
                                        self.summary.center.y += 100.0
                                }
    },
                            completion: nil)
		
    delay(seconds: 0.5) {
      self.summary.text = summaryText
    }
  }

  
  //MARK:- custom methods
  
  func changeFlight(to data: FlightData, animated: Bool = false) {
		// populate the UI with the next flight's data
    
    flightNr.text = data.flightNr
    gateNr.text = data.gateNr
    
    
    if animated {
      //TODO: Call your animation
        
        fade(toImage: UIImage(named: data.weatherImageName)!, showEffects: data.showWeatherEffects)
        
        let offsetDeparting = CGPoint(x: -80.0, y: 0.0)
        let offsetArriving = CGPoint(x: 0.0, y: 50.0)
        
        move(label: departingFrom,
             text: data.departingFrom,
             offset: offsetDeparting)
        move(label: arrivingTo,
             text: data.arrivingTo,
             offset: offsetArriving)
        
        cubeTransition(label: flightStatus, text: data.flightStatus)
        
        planeDepart()
        
        changeSummary(to: data.summary)
    } else {
        summary.text = data.summary
        bgImageView.image = UIImage(named: data.weatherImageName)
        departingFrom.text = data.departingFrom
        arrivingTo.text = data.arrivingTo
        flightStatus.text = data.flightStatus
		}
    
    // schedule next flight
    delay(seconds: 3.0) {
      self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
    }
  }
  
  //MARK:- view controller methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //add the snow effect layer
    snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
    let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
    snowClipView.clipsToBounds = true
    snowClipView.addSubview(snowView)
    view.addSubview(snowClipView)
    
    //start rotating the flights
    changeFlight(to: londonToParis, animated: false)
  }

  
  //MARK:- utility methods
  func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
  }
  
  func duplicateLabel(label: UILabel) -> UILabel {
    let newLabel = UILabel(frame: label.frame)
    newLabel.font = label.font
    newLabel.textAlignment = label.textAlignment
    newLabel.textColor = label.textColor
    newLabel.backgroundColor = label.backgroundColor
    return newLabel
  }
}
