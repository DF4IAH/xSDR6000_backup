//
//  DaxIqViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 1/7/19.
//  Copyright © 2019 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000

class DaxIqViewController: NSViewController {

  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  @IBOutlet private weak var _daxIqPopUp    : NSPopUpButton!
  
  private var _panadapter                   : Panadapter {
    return representedObject as! Panadapter }

  private var _observations                 = [NSKeyValueObservation]()
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _daxIqPopUp.addItems(withTitles: _panadapter.daxIqChoices)
    
    // start observing
    addObservations()
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Action methods
  
  /// Respond to the rxAnt popup
  ///
  /// - Parameter sender:         the popup
  ///
  @IBAction func daxIqPopUp(_ sender: NSPopUpButton) {
    
    _panadapter.daxIqChannel = sender.indexOfSelectedItem
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Observation methods
  
  /// Add observations of various properties used by the view
  ///
  private func addObservations() {
    
    _observations = [
      _panadapter.observe(\.daxIqChannel, options: [.initial, .new], changeHandler: changeHandler(_:_:))
    ]
  }
  /// Process observations
  ///
  /// - Parameters:
  ///   - slice:                    the panadapter being observed
  ///   - change:                   the change
  ///
  private func changeHandler(_ panadapter: Panadapter, _ change: Any) {
    
    DispatchQueue.main.async { [unowned self] in
      self._daxIqPopUp.selectItem(at: panadapter.daxIqChannel)
    }
  }
}

