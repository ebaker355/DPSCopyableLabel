//
//  ViewController.swift
//
//  Created by Eric Baker on 2/Apr/2017.
//  Copyright © 2017 DuneParkSoftware. All rights reserved.
//

//  MIT License
//
//  Copyright (c) 2017 DuneParkSoftware, LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import DPSCopyableLabel
import UIKit

class ViewController: UIViewController {

    var copyableLabel: CopyableLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        copyableLabel = CopyableLabel(frame: CGRect.zero)
        copyableLabel.text = "Created in code"
        view.addSubview(copyableLabel)

        copyableLabel.translatesAutoresizingMaskIntoConstraints = false
        copyableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        copyableLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 40).isActive = true
    }
}
