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

class ViewController: UIViewController {
    @IBOutlet weak var QRview: UIImageView!
    @IBOutlet var Background: UIView!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var warningField: UITextField!
    @IBAction func createButton(_ sender: Any) {
        let str = linkField.text!
        if str != "" {
            QRview.isHidden = false
            warningField.text = "Enjoy your qr-code!"
            warningField.textColor = .green
            QRview.image = generateQRCode(from: str)
        }
        else {
            QRview.isHidden = true
            warningField.text = "You haven't written any link yet!"
            warningField.textColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
