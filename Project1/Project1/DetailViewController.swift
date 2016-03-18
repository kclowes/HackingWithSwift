//
//  DetailViewController.swift
//  Project1
//
//  Created by Keri Clowes on 3/18/16.
//  Copyright © 2016 Keri Clowes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var detailImageView: UIImageView!


  var detailItem: String? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
        if let imageView = self.detailImageView {
          imageView.image = UIImage(named: detail)
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
}

