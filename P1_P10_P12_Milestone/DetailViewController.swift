//
//  DetailViewController.swift
//  P1_P10_P12_Milestone
//
//  Created by Łukasz Nycz on 29/07/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var showedPhoto: UIImageView!
    var selectedPhoto: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButton))

        if let imageToShow = selectedPhoto {
            showedPhoto.image = UIImage(named: "ImageToShow")
            print(imageToShow)
        }
        
    }
    @objc func backButton() {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
    }

}
