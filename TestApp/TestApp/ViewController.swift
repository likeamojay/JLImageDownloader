//
//  ViewController.swift
//  TestApp
//
//  Created by James Lane on 8/14/24.
//

import UIKit
import JLImageDownloader

class ViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if testSingleImage {
            self.tableView.isHidden = true
            self.runTestSingleImage()
        } else {
            self.tableView.isHidden = false
        }
    }
    
    // MARK: - Helpers

    private func runTestSingleImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: 250),
                                     imageView.widthAnchor.constraint(equalToConstant: 250),
                                    ])
        
        imageView.setImage(urlString: beagleImageUrl)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testSingleImage ? 0 : testImageUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        let url = testImageUrls[indexPath.row]
        cell.configure(urlString: url)
        return cell
    }
}

// MARK: - Test TableView Cell

class TestCell: UITableViewCell {
    
    @IBOutlet private var testImageView: UIImageView!
    
    override func prepareForReuse() {
        self.imageView?.image = nil
    }
    
    func configure(urlString: String) {
        self.testImageView.setImage(urlString: urlString)
    }
}
