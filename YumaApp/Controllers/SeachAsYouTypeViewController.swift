//
//  SeachAsYouTypeViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-07-14.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class SeachAsYouTypeViewController: UIViewController
{
	var suggestionBoxOpen = false
	let suggestionBox: UIView =
	{
		let view = UIView()
		return view
	}()
	let suggestionStack: UIStackView =
	{
		let view = UIStackView()
		return view
	}()
	var filtered: [String] = []
	var completeData: [String] = []
	var attachToField: UITextField!
	var filteredAttr: [NSMutableAttributedString] = []


	// MARK: Overrides

	override func viewDidLoad()
	{
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	override var keyCommands: [UIKeyCommand]?
	{
		if suggestionBoxOpen
		{
			return [
				UIKeyCommand(input: UIKeyInputEscape,
							 modifierFlags: [],
							 action: #selector(self.hideSearchBox),
							 discoverabilityTitle: NSLocalizedString("CloseWindow", comment: "Close window"))
			]
		}
		else
		{
			return nil
		}
	}


	// MARK: Methods

	@objc func showStateSearchBox(_ field: UITextField?)
	{
//		if (country.textEdit.text?.isEmpty)! || searchSelectedCountry?.containsStates == false
//		{
//			myAlertOnlyDismiss(self, title: R.string.err, message: "\(R.string.select) \(R.string.country) \(R.string.first)")
//			state.resignFirstResponder()
//		}
//		else
//		{
			suggestionBox.addSubview(suggestionStack)
			view.addSubview(suggestionBox)
			NSLayoutConstraint.activate([
				suggestionBox.topAnchor.constraint(equalTo: attachToField.bottomAnchor, constant: -2),
				suggestionBox.leadingAnchor.constraint(equalTo: attachToField.leadingAnchor, constant: 8),
				suggestionBox.bottomAnchor.constraint(equalTo: attachToField.bottomAnchor, constant: 160),
				suggestionBox.trailingAnchor.constraint(equalTo: attachToField.trailingAnchor, constant: -10),
				
				suggestionStack.topAnchor.constraint(equalTo: suggestionBox.topAnchor, constant: 5),
				suggestionStack.leadingAnchor.constraint(equalTo: suggestionBox.leadingAnchor, constant: 5),
				suggestionStack.bottomAnchor.constraint(equalTo: suggestionBox.bottomAnchor, constant: 5),
				suggestionStack.trailingAnchor.constraint(equalTo: suggestionBox.trailingAnchor, constant: 5),
				])
			filtered = completeData
			suggestionBoxOpen = true
			textChangedSearchBox(field!)
//		}
	}

	@objc func hideSearchBox(_ field: UITextField?)
	{
		suggestionBoxOpen = false
		suggestionBox.removeFromSuperview()
	}

	@objc func textChangedSearchBox(_ textField: UITextField)
	{
		if textField.text == nil || (textField.text?.isEmpty)!
		{
			filtered = completeData
		}
		else
		{
			filtered.removeAll()
			filtered = completeData.filter({ (str) -> Bool in
				return (str.lowercased().contains(attachToField.text!.lowercased()))
			})
			filteredAttr.removeAll()
			//			filteredStatesIDs.removeAll()
			filtered.forEach { (str) in
				//				filteredStatesIDs.append(2)
				filteredAttr.append(hightlightSearchResult(searchString: attachToField.text!, resultString: str))
			}
		}
		suggestionStack.subviews.forEach { (sub) in
			sub.removeFromSuperview()
		}
		for i in 0 ..< 5
		{
			let line = UILabel()
			if filteredAttr.count > i
			{
				line.attributedText = filteredAttr[i]
			}
			else if completeData.count > i
			{
				line.text = completeData[i]
			}
			line.isUserInteractionEnabled = true
			line.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectedFromSearchBox(_:))))
			suggestionStack.addArrangedSubview(line)
		}
		suggestionStack.addArrangedSubview(UIView(frame: .zero))
	}

	@objc func selectedFromSearchBox(_ sender: UITapGestureRecognizer)
	{
		let line = sender.view as! UILabel
		attachToField.text = line.text
		hideSearchBox(nil)
//		stateId = (searchSelectedState?.id!)!
	}

	func hightlightSearchResult(searchString: String, resultString: String) -> NSMutableAttributedString
	{
		let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString)
		let pattern = searchString.lowercased()
		let range: NSRange = NSMakeRange(0, resultString.count)
		
		let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
		
		regex.enumerateMatches(in: resultString.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) -> Void in
			let subRange = textCheckingResult?.range
			attributedString.addAttributes([NSAttributedStringKey.backgroundColor : UIColor.yellow, NSAttributedStringKey.foregroundColor : UIColor.red], range: subRange!)
		}
		return attributedString
	}

}
