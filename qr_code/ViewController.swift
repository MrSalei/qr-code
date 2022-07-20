//
//  ViewController.swift
//  qr_code
//
//  Created by luqrri on 30.06.22.
//

import UIKit

func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
        QRFilter.setValue(data, forKey: "inputMessage")
        guard let QRImage = QRFilter.outputImage else {return nil}
        
        /* SCALING UP
        let transformScale = CGAffineTransform(scaleX: 5.0, y: 5.0)
        let scaledQRImage = QRImage.transformed(by: transformScale)
        return UIImage(ciImage: scaledQRImage)
        */
        
        return UIImage(ciImage: QRImage)
    }
    return nil
}

func verifyUrl(urlString: String?) -> Bool {
    guard let urlString = urlString, let url = URL(string: urlString) else {
        return false
    }
    return UIApplication.shared.canOpenURL(url)
}

class ViewController: UIViewController {
    @IBOutlet weak var QRview: UIImageView!
    @IBOutlet var Background: UIView!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var warningField: UITextField!
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    @IBAction func createButton(_ sender: Any) {
        if !linkField.isEnabled {}
        else if verifyUrl(urlString: linkField.text) {
            QRview.image = generateQRCode(from: linkField.text!)
            warningField.text = "Enjoy your qr-code!"
            warningField.textColor = .green
            linkField.isEnabled = false
        }
        else {
            warningField.text = "Something is wrong with your link!"
            warningField.textColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
