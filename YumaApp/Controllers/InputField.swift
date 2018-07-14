//
//  InputField.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-05-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


enum inputType
{
	/// Email address
	case emailAddress
	/// Capitalizes the letter after a full stop (period .)
	case textCapitalizeSentances
	/// Capitalizes the letter after a space
	case textCapitalizeWords
	/// No capitalization is done
	case textCapitalizeNone
	/// Capitalizes all letters
	case textCapitalizeAll
	/// Replaces each characher with a middle dot
	case hiddenLikePassword
	/// Allows only numerials (0-9)
	case numbersOnly
	/// Allows all numerials (0-9) and slash (\), dash (-), dot (.) characters
	case dateOnly
	/// Allows all numerials (0-9) and slash (\), dash (-), dot (.), colon (:) characters
	case dateAndTime
	/// Allows all numerials (0-9) and colon (:) characters
	case timeOnly
}

struct searchSuggestionElement
{
	let name: String
	let id: Int
}

//		fieldFrame																//
//						/-----------------------------\							//
//						| ^							  |							//
//						|(fieldFrameTop)			  |							//
//						| v							  |							//
// <--fieldFrameLeft-->	| ^							  | <--fieldFrameRight-->
//						|(containerHeight)			  |							//
//						|<---><--><---------------><->|							//
//						|label |  container			  |							//
//						| |	   |   |<-textEditLeft->  |							//
//						| |	   |	|textEdit		  |							//
//						| |	   |	 |<-textEditRight/3->						//
//						| |	   |	  |eye(<-showHideSize->)					//
//						| |	   |	   |<-textEditRight->						//
//						| |  (<-gap->)				  |							//
//						|(<-labelMaxWidth->)		  |							//
//						|  ^						  |							//
//						| (invalidGapTop)			  |							//
//						|  v						  |							//
//						|   --invalid--(invalidHeight)|							//
//						|  ^						  |							//
//						| (invalidGapBottom)		  |							//
//						|  v						  |							//
//						| v							  |							//
//						\-----------------------------/							//
class InputField: UIView
{
	var placeholder = ""
	/// Spacing to top of the whole field
	var fieldFrameTop: Int = 5
	/// Spacing from the left for the whole field
	var fieldFrameLeft: Int = 10
	let fieldFrame: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.borderColor = UIColor.red
		view.borderWidth = 2
		return view
	}()
	/// Whether to make label look like a button - default is no
	var labelLooksLikeButton = false
	let label: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.text = "Label:"
		view.textAlignment = .right
		return view
	}()
	/// Maximum allow space for the field label
	var labelMaxWidth: CGFloat = 120
	/// Space between field label and the dark area surrounding the input field
	var gap: Int = 10
	let container: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		return view
	}()
	/// Height of dark area surrounding the inout field
	var containerHeight: Int = 45
	/// Gap inside dark area, between the left edge and the input field's start
	var textEditLeft: Int = 10
	/// Size of the font in the input field
	var textFontSize: CGFloat = 21
	let textEdit: UITextField =
	{
		let view = UITextField()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.clear
		view.tintColor = R.color.YumaRed
		view.textColor = R.color.YumaRed
		view.font = UIFont.systemFont(ofSize: 21)
		view.autocapitalizationType = .none
		view.isSecureTextEntry = true
		return view
	}()
	/// Gap inside dark area, between the right edge and the input field's end
	var textEditRight: Int = 10
	/// Spacing between the dark area and the whole field's right edge
	var fieldFrameRight: Int = 10
	/// Invalid message font size
	var invalidFontSize: CGFloat = 15
	let invalid: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 15)
		view.textColor = UIColor.red
		view.text = "invalid"
		return view
	}()
	/// Spacing between the dark area's bottom and the invalid message's top
	var invalidGapTop: Int = 2
	/// Height of the invalid message
	var invalidHeight: Int = 20
	/// Spacing between the invalid message's bottom and the whole field
	var invalidGapBottom: Int = 2
//	/// Spacing below the whole field's bottom
//	var fieldFrameBottom: Int = 5
	var inputType: inputType?
	var displayShowHideIcon = false
	/// Size of font for Show/Hide icon
	var showHideSize = 21
	/// Show/Hide icon
	let eye: UILabel =
	{
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.textAlignment = .center
		view.textColor = R.color.YumaRed
		view.font = R.font.FontAwesomeOfSize(pointSize: 21)
		return view
	}()
	var canSee = false
	var suggestionBoxEnabled = false
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
	var filtered: [searchSuggestionElement] = []
	var completeData: [searchSuggestionElement] = []
	var filteredAttr: [NSMutableAttributedString] = []
	var filteredIDs: [Int] = []
	var selectedIdFromSuggestions = -1


	// MARK: Overrides

	override init(frame: CGRect)
	{
		super.init(frame: frame)
		if inputType != nil && inputType == .hiddenLikePassword
		{
			textEdit.isSecureTextEntry = true
		}
		else
		{
			textEdit.isSecureTextEntry = false
		}
		drawField()
	}
	
	init(frame: CGRect, inputType: inputType = .textCapitalizeSentances, hasShowHideIcon: Bool = false, labelLooksLikeButton: Bool = false, searchAsYouType: Bool = false)
	{
		super.init(frame: frame)
		self.displayShowHideIcon = hasShowHideIcon
		if labelLooksLikeButton
		{
			label.backgroundColor = R.color.YumaYel.withAlphaComponent(0.5)
			label.cornerRadius = 4
			label.borderWidth = 1
			label.borderColor = R.color.YumaRed
			label.textAlignment = .center
		}
		textEdit.isSecureTextEntry = false
		switch inputType
		{
		case .emailAddress:
			textEdit.keyboardType = .emailAddress
			textEdit.autocapitalizationType = .none
			break
		case .textCapitalizeAll:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .allCharacters
			break
		case .textCapitalizeNone:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .none
			break
		case .textCapitalizeSentances:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .sentences
			break
		case .textCapitalizeWords:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .words
			break
		case .numbersOnly:
			textEdit.keyboardType = .decimalPad
			break
		case .dateOnly:
			textEdit.keyboardType = .phonePad
			break
		case .dateAndTime:
			textEdit.keyboardType = .phonePad
			break
		case .timeOnly:
			textEdit.keyboardType = .phonePad
			break
		case .hiddenLikePassword:
			textEdit.keyboardType = .asciiCapable
			textEdit.autocapitalizationType = .none
			textEdit.isSecureTextEntry = true
			break
		}
		self.suggestionBoxEnabled = searchAsYouType
		main()
//		drawField()
//		if suggestionBoxEnabled
//		{
//			textEdit.addTarget(self, action: #selector(showSearchBox(_:)), for: UIControlEvents.editingDidBegin)
//			textEdit.addTarget(self, action: #selector(hideSearchBox(_:)), for: UIControlEvents.editingDidEnd)
//			textEdit.addTarget(self, action: #selector(textChangedSearchBox(_:)), for: UIControlEvents.editingChanged)
//		}
	}

	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		//fatalError("init(coder:) has not been implemented")
		if inputType != nil && inputType == .hiddenLikePassword
		{
			textEdit.isSecureTextEntry = true
		}
		main()
	}


	// MARK: Methods

	private func main()
	{
		drawField()
		if suggestionBoxEnabled
		{
			textEdit.addTarget(self, action: #selector(showSearchBox(_:)), for: UIControlEvents.editingDidBegin)
			textEdit.addTarget(self, action: #selector(hideSearchBox(_:)), for: UIControlEvents.editingDidEnd)
			textEdit.addTarget(self, action: #selector(textChangedSearchBox(_:)), for: UIControlEvents.editingChanged)
		}
	}

	private func drawField()
	{
		label.adjustsFontSizeToFitWidth = true
		fieldFrame.addSubview(label)
		textEdit.placeholder = self.placeholder
		if textFontSize != 21
		{
			textEdit.font = UIFont.systemFont(ofSize: textFontSize)
		}
		container.addSubview(textEdit)
		if displayShowHideIcon
		{
			eye.text = canSee ? FontAwesome.eyeSlash.rawValue : FontAwesome.eye.rawValue
			eye.isUserInteractionEnabled = true
			eye.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleViewable(_:))))
			if showHideSize != 21
			{
				eye.font = R.font.FontAwesomeOfSize(pointSize: showHideSize)
			}
			container.addSubview(eye)
			container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(max(4, textEditRight/3))-[v1(\(showHideSize))]-\(textEditRight)-|", views: textEdit, eye)
			container.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
			container.addConstraint(NSLayoutConstraint(item: eye, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		}
		else
		{
			container.addConstraintsWithFormat(format: "H:|-\(textEditLeft)-[v0]-\(textEditRight)-|", views: textEdit)
			container.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		}
		fieldFrame.addSubview(container)
		fieldFrame.addSubview(invalid)
		if invalidFontSize != 15
		{
			textEdit.font = UIFont.systemFont(ofSize: invalidFontSize)
		}
		addSubview(fieldFrame)
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0(\(labelMaxWidth))]-\(gap)-[v1]-\(fieldFrameRight)-|", views: label, container)
		fieldFrame.addConstraintsWithFormat(format: "H:|-\(fieldFrameLeft)-[v0]-\(fieldFrameRight)-|", views: invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0]-\(invalidGapTop)-[v1(\(invalidHeight))]-\(invalidGapBottom)-|", views: label, invalid)
		fieldFrame.addConstraintsWithFormat(format: "V:|-\(fieldFrameTop)-[v0(\(containerHeight))]", views: container)
		container.addConstraintsWithFormat(format: "V:|[v0]|", views: textEdit)
		fieldFrame.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		fieldFrame.addConstraint(NSLayoutConstraint(item: textEdit, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0))
		addConstraintsWithFormat(format: "H:|[v0]|", views: fieldFrame)
		addConstraintsWithFormat(format: "V:|[v0]|", views: fieldFrame)
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


	@objc func toggleViewable(_ sender: AnyObject)
	{
		canSee = !canSee
		eye.text = canSee ? FontAwesome.eyeSlash.rawValue : FontAwesome.eye.rawValue
		textEdit.isSecureTextEntry = canSee ? false : true
	}


	@objc func showSearchBox(_ field: UITextField?)
	{
		//		if (country.textEdit.text?.isEmpty)! || searchSelectedCountry?.containsStates == false
		//		{
		//			myAlertOnlyDismiss(self, title: R.string.err, message: "\(R.string.select) \(R.string.country) \(R.string.first)")
		//			state.resignFirstResponder()
		//		}
		//		else
		//		{
		if suggestionBoxEnabled
		{
			suggestionBox.addSubview(suggestionStack)
			addSubview(suggestionBox)
			NSLayoutConstraint.activate([
				suggestionBox.topAnchor.constraint(equalTo: textEdit.bottomAnchor, constant: -2),
				suggestionBox.leadingAnchor.constraint(equalTo: textEdit.leadingAnchor, constant: 8),
				suggestionBox.bottomAnchor.constraint(equalTo: textEdit.bottomAnchor, constant: 160),
				suggestionBox.trailingAnchor.constraint(equalTo: textEdit.trailingAnchor, constant: -10),
				
				suggestionStack.topAnchor.constraint(equalTo: suggestionBox.topAnchor, constant: 5),
				suggestionStack.leadingAnchor.constraint(equalTo: suggestionBox.leadingAnchor, constant: 5),
				suggestionStack.bottomAnchor.constraint(equalTo: suggestionBox.bottomAnchor, constant: 5),
				suggestionStack.trailingAnchor.constraint(equalTo: suggestionBox.trailingAnchor, constant: 5),
				])
			filtered = completeData
			suggestionBoxOpen = true
			textChangedSearchBox(field!)
		}
	}
	

	@objc func hideSearchBox(_ field: UITextField?)
	{
		suggestionBoxOpen = false
		suggestionBox.removeFromSuperview()
	}
	

	@objc private func textChangedSearchBox(_ textField: UITextField)
	{
		if textField.text == nil || (textField.text?.isEmpty)!
		{
			filtered = completeData
		}
		else
		{
			filtered.removeAll()
			filtered = completeData.filter({ (str) -> Bool in
				return (str.name.lowercased().contains(textField.text!.lowercased()))
			})
			filteredAttr.removeAll()
			filteredIDs.removeAll()
			filtered.forEach { (str) in
				filteredIDs.append(str.id)
				filteredAttr.append(hightlightSearchResult(searchString: textField.text!, resultString: str.name))
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
				line.text = completeData[i].name
			}
			line.isUserInteractionEnabled = true
			line.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectedFromSearchBox(_:))))
			suggestionStack.addArrangedSubview(line)
		}
		suggestionStack.addArrangedSubview(UIView(frame: .zero))
	}
	

	@objc private func selectedFromSearchBox(_ sender: UITapGestureRecognizer)
	{
		let line = sender.view as! UILabel
		textEdit.text = line.text
		hideSearchBox(nil)
		for i in 0 ..< 5
		{
			if filtered[i].name == line.text
			{
				selectedIdFromSuggestions = filtered[i].id
				break
			}
		}
	}

}
