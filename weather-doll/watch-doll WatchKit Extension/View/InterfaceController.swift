//
//  InterfaceController.swift
//  watch-doll WatchKit Extension
//
//  Created by 박익범 on 2022/03/02.
//

import WatchKit
import UIKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    let session = WCSession.default
    var longitude: String = ""
    var latitude: String = ""
    
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    @IBOutlet weak var tempLabel: WKInterfaceLabel!
    @IBOutlet weak var iconImageView: WKInterfaceImage!
    
    @IBOutlet weak var tempDetailLabel: WKInterfaceLabel!
    @IBOutlet weak var humdityLabel: WKInterfaceLabel!
    @IBOutlet weak var dustLabel: WKInterfaceLabel!
    @IBOutlet weak var highDustLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session.delegate = self
        session.activate()
//         Configure interface objects here.
    }
    
    private getWeatherDataFunc(){
        
    }
    
    
    
    
    override func willActivate() {
        super.willActivate()
        print("willActivate")
        session.activate()

        // This method is called when watch view controller is about to be visible to user

    }
    
    override func didDeactivate() {
        super.didDeactivate()
        print("didDeactivate")
        // This method is called when watch view controller is no longer visible

    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let value = userInfo["iPhone"] as? String {
            print(value)
            DispatchQueue.main.async {
                if let value = userInfo["iPhone"] as? String
                { self.locationLabel.setText(value)}
            }
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any] = [:]) {
       if let value = message["iPhone"] as? String {
         self.locationLabel.setText(value)
       }
     }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any] = [:]) {
        if let value = applicationContext["iPhone"] as? String {
          self.locationLabel.setText(value)
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            self.locationLabel.setText(session.applicationContext as? String)
        }

    }


}

