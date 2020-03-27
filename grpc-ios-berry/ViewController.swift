//
//  ViewController.swift
//  grpc-ios-berry
//
//  Created by na.savchenko on 26.03.2020.
//  Copyright © 2020 Mel Absinthiatum. All rights reserved.
//

import UIKit
import Alamofire
import BerryGrpcClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func greenberryDidTap(_ sender: UIButton) {
        let greenberry = BRRGreenberryRequest()
        greenberry.name = "name"
        
        guard let data = greenberry.data() else {
            print("serialization error")
            return
        }
        
        do {
            let regreenberry = try BRRGreenberryRequest(data: data)
            if regreenberry.name == "name" {
                print("done")
            }
        }
        catch {
            print("deserializaation error")
            return
        }
    }
}

