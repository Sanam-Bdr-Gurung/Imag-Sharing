//
//  ViewController.swift
//  Project1
//
//  Created by Sanam Gurung on 8/12/24.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        
        // IOS App bundle always have resource path so enforcing implicit unwrapped optional
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        pictures.sort()
        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.appHeaderTitle = "\(indexPath.row+1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

