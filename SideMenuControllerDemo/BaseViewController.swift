/*****************************************************************************
 *
 * FILE:	BaseViewController.swift
 * DESCRIPTION:	SideMenuControllerDemo: Application Base View Controller
 * DATE:	Tue, Feb 19 2019
 * UPDATED:	Tue, Feb 19 2019
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		http://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2019 阿部康一／Kouichi ABE (WALL), All rights reserved.
 * LICENSE:
 *
 *  Copyright (c) 2019 Kouichi ABE (WALL) <kouichi@MagickWorX.COM>,
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 *   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *   INTERRUPTION)  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 *
 *****************************************************************************/

import Foundation
import UIKit

class BaseViewController: UIViewController
{
  public internal(set) var app: AppDelegate = UIApplication.shared.delegate as! AppDelegate

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    setup()
  }

  override func loadView() {
    super.loadView()

    self.edgesForExtendedLayout = []
    self.extendedLayoutIncludesOpaqueBars = true

    self.view.backgroundColor = .white
    self.view.autoresizesSubviews = true
    self.view.autoresizingMask	= [ .flexibleWidth, .flexibleHeight ]
  }

  func setup() {
    // actual contents of init(). subclass can override this.
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    if self.isModal {
      let closeItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseAction))
      self.navigationItem.leftBarButtonItem = closeItem
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension BaseViewController
{
  var isModal: Bool {
    if let viewControllers = self.navigationController?.viewControllers,
       let rootViewController = viewControllers.first {
      return rootViewController == self && rootViewController.presentingViewController != nil
    }
    return false
  }

  @objc func handleCloseAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension BaseViewController
{
  public func popup(title: String, message: String) {
    autoreleasepool {
      let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertController, animated: true, completion: nil)
    }
  }

  public func showModal(_ viewController: UIViewController, animated: Bool, completion: (()->Void)? = nil) {
    let navigationController = UINavigationController(rootViewController: viewController)
    if let parentNavigationController = self.navigationController {
      parentNavigationController.present(navigationController, animated: true, completion: completion)
    }
    else {
      self.present(navigationController, animated: true, completion: completion)
    }
  }
}
