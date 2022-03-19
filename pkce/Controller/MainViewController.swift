//
//  MainViewController.swift
//  pkce
//
//  Created by Ricardo Bravo on 19/03/22.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var text: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.text.text = ""
    }
    
    @IBAction func get(_ sender: UIButton) {
        ApiClient.movie { response, error in
            if error != nil {
                self.text.text = error?.localizedDescription ?? "Error..."
            } else {
                self.text.text = response?[0].title
            }
        }
    }
    
    @IBAction func post(_ sender: Any) {
        let request = TransactionRequest(clientId: "100", amount: "100")
        ApiClient.transaction(request: request, completion: { response, error in
            if error != nil {
                self.text.text = error?.localizedDescription ?? "Error..."
            } else {
                self.text.text = response?.message
            }
        })
    }
}
