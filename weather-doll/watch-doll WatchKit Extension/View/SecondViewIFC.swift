//
//  SecondViewIFC.swift
//  watch-doll WatchKit Extension
//
//  Created by 박익범 on 2022/03/02.
//

import WatchKit
import Foundation

class SecondViewIFC: WKInterfaceController {
    
    
    @IBOutlet weak var foodIndexNameLabel: WKInterfaceLabel!
    @IBOutlet weak var hobbyIndexNameLabel: WKInterfaceLabel!
    @IBOutlet weak var lifeIndexNameLabel: WKInterfaceLabel!
    @IBOutlet weak var clothNameLabel: WKInterfaceLabel!
    
    @IBOutlet weak var foodIndexNumLabel: WKInterfaceLabel!
    @IBOutlet weak var hobbyIndexNumLabel: WKInterfaceLabel!
    @IBOutlet weak var lifeIndexNumLabel: WKInterfaceLabel!
    @IBOutlet weak var clothIndexNumLAbel: WKInterfaceLabel!
    

    func setData(food: [String], hobby: [String], life: [String], cloth: [String]){
        foodIndexNameLabel.setText(food[0])
        foodIndexNumLabel.setText(food[1])
        hobbyIndexNameLabel.setText(hobby[0])
        hobbyIndexNumLabel.setText(hobby[1])
        lifeIndexNameLabel.setText(life[0])
        lifeIndexNumLabel.setText(life[1])
        clothNameLabel.setText(cloth[0])
        clothIndexNumLAbel.setText(cloth[1])
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        sendToSecondViewData()
    }
    
    func sendToSecondViewData(){
        let view = SecondViewIFC()
        view.setData(food: ["빙수 지수", "99"], hobby: ["수영 지수", "90"], life: ["빨래 지수", "93"], cloth: ["반팔 지수", "100"])
    }
    
    
    override func willActivate() {
        super.willActivate()
        print("willActivate")
        // This method is called when watch view controller is about to be visible to user

    }
    
    override func didDeactivate() {
        super.didDeactivate()
        print("didDeactivate")
        // This method is called when watch view controller is no longer visible

    }
    override init() {
        super.init()
    }
}
