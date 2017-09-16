//
//  PassageTableViewCell.swift
//  A-Lang
//
//  Created by Saurabh Gupta on 16/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit
import ActiveLabel
import EasyTipView

class PassageTableViewCell: UITableViewCell {

    @IBOutlet weak var passageTextLabel: ActiveLabel!
    private var customURLs: [ActiveType] = []
    private var sentences: [BilingualText] = []
    private var recognizer: UITapGestureRecognizer!

    func configure(with model: PassageDetailsCellModel?) {
        passageTextLabel.attributedText = NSAttributedString(string: model?.passageText ?? "")
        sentences = model?.sentences ?? [BilingualText]()
        passageTextLabel.isEnabled = false

        recognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))

        passageTextLabel.addGestureRecognizer(recognizer)
        passageTextLabel.isUserInteractionEnabled = true
    }

    @objc func tapped() {
        let attributedString = passageTextLabel.attributedText ?? NSAttributedString()

        // Storage class stores the string, obviously
        let textStorage: NSTextStorage = NSTextStorage(attributedString: attributedString)

        // The storage class owns a layout manager
        let layoutManager: NSLayoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        // Layout manager owns a container which basically
        // defines the bounds the text should be contained in
        let textContainer: NSTextContainer = NSTextContainer(size: passageTextLabel.frame.size)
        layoutManager.addTextContainer(textContainer)
        // For labels the fragment padding should be 0
        textContainer.lineFragmentPadding = 0;

        // Begin computation of actual frame
        // Glyph is the final display representation
        // Eg: Ligatures have 2 characters but only 1 glyph.
        for link in sentences {
            let range = (attributedString.string as NSString).range(of: link.spanish ?? "")
            let glyphRange: NSRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
            let glyphRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)

            let touchPoint = recognizer.location(ofTouch: 0, in: self.passageTextLabel)
            if glyphRect.contains(touchPoint) {
                print(link.english)
            }
        }
    }
}
