//
//  RatingControl.swift
//  LastChance
//
//  Created by Ben Chaimberg on 2/5/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var spacing = 5
    var stars = 5
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        super.init(coder: aDecoder)
        
        for _ in 0..<stars {
            let button = UIButton()
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            ratingButtons += [button]
            addSubview(button)
        }
    }
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }

    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        if ratingButtons.indexOf(button)! == 0 {
            if button.selected && !ratingButtons[1].selected {
                rating = 0
            }
        }
        updateButtonSelectionStates()
    }
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
