//
//  ModeViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 5/9/18.
//  Copyright © 2018 Douglas Adams. All rights reserved.
//

import Foundation
import xLib6000
import SwiftyUserDefaults

// --------------------------------------------------------------------------------
// MARK: - Mode View Controller class implementation
// --------------------------------------------------------------------------------

final public class ModeViewController       : NSViewController {

//  static let filterChoices    = [                             // Names of filters (by mode)
//    "AM"    : ["5.6k", "6.0k", "8.0k", "10k", "12k", "14k", "16k", "20k"],
//    "SAM"   : ["5.6k", "6.0k", "8.0k", "10k", "12k", "14k", "16k", "20k"],
//    "CW"    : ["50", "100", "250", "400", "800", "1.0k", "1.5k", "3.0k"],
//    "USB"   : ["1.6k", "1.8k", "2.1k", "2.4k", "2.7k", "2.9k", "3.3k", "4.0k"],
//    "LSB"   : ["1.6k", "1.8k", "2.1k", "2.4k", "2.7k", "2.9k", "3.3k", "4.0k"],
//    "FM"    : [],
//    "NFM"   : [],
//    "DFM"   : ["6.0k", "8.0k", "10k", "12k", "14k", "16k", "18k", "20k"],
//    "DIGU"  : ["100", "300", "600", "1.0k", "1.5k", "2.0k", "3.0k", "5.0k"],
//    "DIGL"  : ["100", "300", "600", "1.0k", "1.5k", "2.0k", "3.0k", "5.0k"],
//    "RTTY"  : ["250", "300", "350", "400", "500", "1.0k", "1.5k", "3.0k"]
//  ]
  static let filterValues    = [                              // Values of filters (by mode)
    "AM"    : [3_000, 4_000, 5_600, 6_000, 8_000, 10_000, 12_000, 14_000, 16_000, 20_000],
    "SAM"   : [3_000, 4_000, 5_600, 6_000, 8_000, 10_000, 12_000, 14_000, 16_000, 20_000],
    "CW"    : [50, 75, 100, 150, 250, 400, 800, 1_000, 1_500, 3_000],
    "USB"   : [1_200, 1_400, 1_600, 1_800, 2_100, 2_400, 2_700, 2_900, 3_300, 4_000],
    "LSB"   : [1_200, 1_400, 1_600, 1_800, 2_100, 2_400, 2_700, 2_900, 3_300, 4_000],
    "FM"    : [],
    "NFM"   : [],
    "DFM"   : [3_000, 4_000, 6_000, 8_000, 10_000, 12_000, 14_000, 16_000, 18_000, 20_000],
    "DIGU"  : [100, 200, 300, 400, 600, 1_000, 1_500, 2_000, 3_000, 5_000],
    "DIGL"  : [100, 200, 300, 400, 600, 1_000, 1_500, 2_000, 3_000, 5_000],
    "RTTY"  : [250, 300, 350, 400, 450, 500, 750, 1_000, 1_500, 3_000]
  ]
  
// ----------------------------------------------------------------------------
// MARK: - Internal properties

  @objc dynamic public var mode             : String {
    get { return (representedObject as! xLib6000.Slice).mode }
    set { (representedObject as! xLib6000.Slice).mode = newValue }
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  @IBOutlet private weak var _modePopup     : NSPopUpButton!
  
  @IBOutlet private weak var _quickMode0    : NSButton!
  @IBOutlet private weak var _quickMode1    : NSButton!
  @IBOutlet private weak var _quickMode2    : NSButton!
  @IBOutlet private weak var _quickMode3    : NSButton!

  @IBOutlet private weak var _filter0       : NSButton!
  @IBOutlet private weak var _filter1       : NSButton!
  @IBOutlet private weak var _filter2       : NSButton!
  @IBOutlet private weak var _filter3       : NSButton!
  @IBOutlet private weak var _filter4       : NSButton!
  @IBOutlet private weak var _filter5       : NSButton!
  @IBOutlet private weak var _filter6       : NSButton!
  @IBOutlet private weak var _filter7       : NSButton!
  @IBOutlet private weak var _filter8       : NSButton!
  @IBOutlet private weak var _filter9       : NSButton!
  
  private var _slice                        : xLib6000.Slice {
    return representedObject as! xLib6000.Slice }

  private var _observations                 : [NSKeyValueObservation]?
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  public override func viewDidLoad() {
    super.viewWillAppear()
    
    if _observations == nil {
      _observations = [NSKeyValueObservation]()
      
      _modePopup.addItems(withTitles: _slice.modeList)
      
      addObservations()
    }
    _quickMode0.title = Defaults[.quickMode0].uppercased()
    _quickMode1.title = Defaults[.quickMode1].uppercased()
    _quickMode2.title = Defaults[.quickMode2].uppercased()
    _quickMode3.title = Defaults[.quickMode3].uppercased()
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Action methods

  /// Respond to the Mode popup
  ///
  /// - Parameter sender:         the popup
  ///
  @IBAction func modeButton(_ sender: NSPopUpButton) {
    _slice.mode = sender.titleOfSelectedItem!
  }
  /// Respond to one of the Quick Mode buttons
  ///
  /// - Parameter sender:         the button
  ///
  @IBAction func quickModeButtons(_ sender: NSButton) {
    
    switch sender.tag {
    case 0:
      mode = Defaults[.quickMode0].uppercased()
    case 1:
      mode = Defaults[.quickMode1].uppercased()
    case 2:
      mode = Defaults[.quickMode2].uppercased()
    case 3:
      mode = Defaults[.quickMode3].uppercased()
    default:
      // unknown tag
      break
    }
  }
  /// Respond to one of the Filter buttons
  ///
  /// - Parameter sender:           the button
  ///
  @IBAction func filterButtons(_ sender: NSButton) {
    
    // get the possible filters for the current mode
    guard let filters = ModeViewController.filterValues[mode] else { return }
    
    // get the width of the filter
    let filterValue = filters[sender.tag]
    
    let slice = representedObject as! xLib6000.Slice
    
    // position the filter based on mode
    switch Slice.Mode(rawValue: mode)! {
    case .RTTY, .DFM, .AM, .SAM:
      slice.filterLow = -filterValue/2
      slice.filterHigh = +filterValue/2
    
    case .CW, .USB, .DIGU:
      slice.filterLow = +100
      slice.filterHigh = +filterValue + 100
    
    case .LSB, .DIGL:
      slice.filterLow = -filterValue - 100
      slice.filterHigh = -100
    
    case .FM:
      slice.filterLow = -8_000
      slice.filterHigh = +8_000
    
    case .NFM:
      slice.filterLow = -5_500
      slice.filterHigh = +5_500

    // FIXME: are these needed?

//    case .dsb:
//      break
//    case .dstr:
//      break
//    case .fdv:
//      break
    }
  }
  /// Return a list of Filter Width strings
  ///
  /// - Parameter mode:             a Mode name
  /// - Returns:                    an array of String
  ///
  private func filterStrings( for mode: String) -> [String] {
    var array = [String]()
    
    if let values = ModeViewController.filterValues[mode] {
      var formattedWidth = ""
      
      values.forEach( {
        switch $0 {
        case 1_000...:
          formattedWidth = String(format: "%2.1fk", Float($0)/1000.0)
        case 0..<1_000:
          formattedWidth = String(format: "%3d", $0)
        default:
          formattedWidth = "0"
        }
        array.append(formattedWidth)
      } )
    }
    return array
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Observation methods
  
  /// Add observations of various properties used by the view
  ///
  private func addObservations() {
    
    _observations = [
      _slice.observe(\.mode, options: [.initial, .new], changeHandler: changeHandler(_:_:)),
    ]
  }
  /// Process observations
  ///
  /// - Parameters:
  ///   - object:                   the object being observed
  ///   - change:                   the change
  ///
  private func changeHandler(_ object: Any, _ change: Any) {
    
    let slice = object as! xLib6000.Slice
    
    let filterTitles = filterStrings(for: slice.mode)

    DispatchQueue.main.async { [unowned self] in
      self._filter0.title = filterTitles[0]
      self._filter1.title = filterTitles[1]
      self._filter2.title = filterTitles[2]
      self._filter3.title = filterTitles[3]
      self._filter4.title = filterTitles[4]
      self._filter5.title = filterTitles[5]
      self._filter6.title = filterTitles[6]
      self._filter7.title = filterTitles[7]
      self._filter8.title = filterTitles[8]
      self._filter9.title = filterTitles[9]
    }
  }
}