//
//  CopyableLabel.swift
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

import UIKit

@IBDesignable open class CopyableLabel: UILabel {

    @IBInspectable open var copyable: Bool = true

    //
    // MARK: - Overrides
    //

    public init() {
        super.init(frame: CGRect.zero)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        installCopyGestureRecognizer()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installCopyGestureRecognizer()
    }

    open override var canBecomeFirstResponder: Bool {
        return copyable
    }

    open override func becomeFirstResponder() -> Bool {
        let retVal = super.becomeFirstResponder() && copyable
        return retVal
    }

    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let retVal = self.responds(to: action)
        return retVal
    }

    open override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }

    open override var description: String {
        get {
            var desc = super.description
            var index = desc.index(desc.endIndex, offsetBy: -1)
            if desc.hasSuffix(">)") {
                index = desc.index(desc.endIndex, offsetBy: -2)
            }
            desc.replaceSubrange(index..<index, with: "; copyable = \(copyable)")
            return desc
        }
    }

    //
    // MARK: - Private
    //

    private var copyGestureRecognizer: UILongPressGestureRecognizer? = nil

    private func installCopyGestureRecognizer() {
        guard copyGestureRecognizer == nil else { return }

        copyGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(recognizedCopyGesture(_:)))
        addGestureRecognizer(copyGestureRecognizer!)
        isUserInteractionEnabled = true
    }

    @objc private func recognizedCopyGesture(_ gesture: UIGestureRecognizer) {
        guard
            gesture == copyGestureRecognizer,
            gesture.state == .began,
            copyable
            else { return }

        presentMenuController()
    }

    private func presentMenuController() {
        let menuController = UIMenuController.shared

        guard
            !menuController.isMenuVisible,
            let superview = superview,
            becomeFirstResponder()
            else { return }

        menuController.setTargetRect(self.frame, in: superview)
        menuController.setMenuVisible(true, animated: UIView.areAnimationsEnabled)
    }
}
