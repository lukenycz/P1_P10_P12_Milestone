//
//  DetailViewController.swift
//  P1_P10_P12_Milestone
//
//  Created by Łukasz Nycz on 29/07/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var showedPhoto: UIImageView!
    var selectedPhoto: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Rename", style: .done, target: self, action: #selector(renamePhoto))
        
        if let imageToShow = selectedPhoto {
            showedPhoto.image = UIImage(named: imageToShow)
        }
        
    }
    
    @objc func renamePhoto() {
        }

}
