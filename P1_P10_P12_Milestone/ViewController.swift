//
//  ViewController.swift
//  P1_P10_P12_Milestone
//
//  Created by Łukasz Nycz on 29/07/2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photo = [Photos]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choosePicture))    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photo.count
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            photo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let onePhoto = photo[indexPath.row]
        cell.textLabel?.text = onePhoto.name
        cell.detailTextLabel?.text = onePhoto.image
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let onePhoto = photo[indexPath.row]
        let mainAlert = UIAlertController(title: "-", message: "Select an Option", preferredStyle: .actionSheet)
                
                mainAlert.addAction(UIAlertAction(title: "Rename", style: .destructive) { [weak self] _ in
                    let ac = UIAlertController(title: "Rename photo", message: nil, preferredStyle: .alert)
                    ac.addTextField()
                    
                    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                        guard let newName = ac?.textFields?[0].text else { return }
                        onePhoto.name = newName
                        self?.tableView.reloadData()
                    })
                    
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self?.present(ac, animated: true)
                })
        mainAlert.addAction(UIAlertAction(title: "Show Photo", style: .default) { [weak self] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                let onePhoto = self?.photo[indexPath.row]
                vc.selectedPhoto = onePhoto?.image
                self?.navigationController?.pushViewController(vc, animated: true)
                self?.photo[indexPath.row] = onePhoto!
            }
        })
        mainAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(mainAlert, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let onePhoto = photo[indexPath.row]
            vc.selectedPhoto = onePhoto.image
            navigationController?.pushViewController(vc, animated: true)
            photo[indexPath.row] = onePhoto
        }
    }
    
    @objc func choosePicture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let onePhoto = Photos(name: "Unknown", image: imageName)
        photo.append(onePhoto)
        tableView.reloadData()
        dismiss(animated: true)
        print(onePhoto.image)

    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

