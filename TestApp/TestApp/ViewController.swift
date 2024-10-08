//
//  ViewController.swift
//  TestApp
//
//  Created by James Lane on 8/14/24.
//

import JLImageDownloader
import UIKit

class ViewController: UIViewController {
    
    let testImageUrls = ["https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg",
         "https://cdn.britannica.com/79/232779-050-6B0411D7/German-Shepherd-dog-Alsatian.jpg",
         "https://www.nylabone.com/-/media/project/oneweb/nylabone/images/dog101/10-intelligent-dog-breeds/golden-retriever-tongue-out.jpg",
         "https://www.pedigree.com/sites/g/files/fnmzdf3076/files/2023-05/what-breed-my-dog-540x300.png",
         "https://upload.wikimedia.org/wikipedia/commons/c/c0/Mongrel_1.jpg",
         "https://cdn-prod.medicalnewstoday.com/content/images/articles/322/322868/golden-retriever-puppy.jpg",
         "https://hgtvhome.sndimg.com/content/dam/images/hgtv/fullset/2022/6/16/1/shutterstock_1862856634.jpg.rend.hgtvcom.1280.960.suffix/1655430860853.jpeg",
         "https://d.newsweek.com/en/full/2390494/husky-dog-bed.jpg",
         "https://image.petmd.com/files/styles/863x625/public/dog-allergies.jpg",
         "https://static.scientificamerican.com/sciam/cache/file/83E08CB2-1686-4F82-BA7D9E2B255EC0FD_source.jpg",
    ]
    
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testImageUrls.count
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.testImageView.image = UIImage(named: "loading_icon", in: Bundle.jlImageDownloader, with:  UIImage.SymbolConfiguration(scale: .default))
    }
    
    override func prepareForReuse() {
        self.imageView?.image = nil
    }
    
    func configure(urlString: String) {
        self.testImageView.setImage(urlString: urlString)
    }
}
