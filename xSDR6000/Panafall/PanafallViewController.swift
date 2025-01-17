//
//  PanafallViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 10/14/15.
//  Copyright © 2015 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000

// --------------------------------------------------------------------------------
// MARK: - Panafall View Controller class implementation
// --------------------------------------------------------------------------------

final class PanafallViewController          : NSSplitViewController, NSGestureRecognizerDelegate {
 
  static let kEdgeTolerance                 : CGFloat = 0.1                 // percent of bandwidth

  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  @IBOutlet private weak var _panadapterSplitViewItem: NSSplitViewItem!
  
  private weak var _panadapter              : Panadapter?
  private var _center                       : Int {return _panadapter!.center }
  private var _bandwidth                    : Int { return _panadapter!.bandwidth }
  private var _start                        : Int { return _center - (_bandwidth/2) }
  private var _end                          : Int { return _center + (_bandwidth/2) }
  private var _hzPerUnit                    : CGFloat { return CGFloat(_end - _start) / view.frame.width }
  
  private weak var _panadapterViewController  : PanadapterViewController? { return _panadapterSplitViewItem.viewController as? PanadapterViewController }
  
  private var _rightClick                   : NSClickGestureRecognizer!
  private let kLeftButton                   = 0x01                          // masks for Gesture Recognizers
  private let kRightButton                  = 0x02

  private let kButtonViewWidth              : CGFloat = 75                  // Width of ButtonView when open
  
  private let kCreateSlice                  = "Create Slice"                // Menu titles
  private let kRemoveSlice                  = "Remove Slice"
  private let kCreateTnf                    = "Create Tnf"
  private let kRemoveTnf                    = "Remove Tnf"
  private let kPermanentTnf                 = "Permanent"
  private let kNormalTnf                    = "Normal"
  private let kDeepTnf                      = "Deep"
  private let kVeryDeepTnf                  = "Very Deep"

  private let kTnfFindWidth: CGFloat        = 0.01                          // * bandwidth = Tnf tolerance multiplier
  private let kSliceFindWidth: CGFloat      = 0.01                          // * bandwidth = Slice tolerance multiplier

  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  /// the View has loaded
  ///
  override func viewDidLoad() {
    super.viewDidLoad()
    
    #if XDEBUG
    Swift.print("\(#function) - \(URL(fileURLWithPath: #file).lastPathComponent.dropLast(6))")
    #endif

    splitView.delegate = self
    
    // setup Right Single Click recognizer
    _rightClick = NSClickGestureRecognizer(target: self, action: #selector(rightClick(_:)))
    _rightClick.buttonMask = kRightButton
    _rightClick.numberOfClicksRequired = 1
    splitView.addGestureRecognizer(_rightClick)
    
    // save the divider position
    splitView.autosaveName = "Panadapter \(_panadapter?.streamId.hex ?? "0x99999999")"
  }
  /// Process scroll wheel events to change the Active Slice frequency
  ///
  /// - Parameter theEvent: a Scroll Wheel event
  ///
  override func scrollWheel(with theEvent: NSEvent) {
    
    // ignore events not in the Y direction
    if theEvent.deltaY != 0 {
      
      // find the Active Slice
      if let slice = Slice.findActive(with: _panadapter!.streamId) {
        
        // use the Slice's step value, unless the Shift key is down
        var step = slice.step
        if theEvent.modifierFlags.contains(.shift) && !theEvent.modifierFlags.contains(.option) {
          // step value when the Shift key is down
          step = 100
        } else if theEvent.modifierFlags.contains(.option) && !theEvent.modifierFlags.contains(.shift) {
          // step value when the Option key is down
          step = 10
        } else if theEvent.modifierFlags.contains(.option)  && theEvent.modifierFlags.contains(.shift) {
          // step value when the Option key is down
          step = 1
        }
        var incr = 0
        // is scrolling "natural" or "classic" (as set in macOS System Preferences)
        if theEvent.isDirectionInvertedFromDevice {
          // natural
          incr = theEvent.deltaY < 0 ? step : -step
        } else {
          // classic
          incr = theEvent.deltaY < 0 ? -step : step
        }
        // update the frequency
        adjustSliceFrequency(slice, incr: incr)
      }
    }
  }
  #if XDEBUG
  deinit {
    Swift.print("\(#function) - \(URL(fileURLWithPath: #file).lastPathComponent.dropLast(6))")
  }
  #endif

  // ----------------------------------------------------------------------------
  // MARK: - Internal methods
  
  /// Configure needed parameters
  ///
  /// - Parameter panadapter:               a Panadapter reference
  ///
  func configure(panadapter: Panadapter?) {
    self._panadapter = panadapter
  }

  // ----------------------------------------------------------------------------
  // MARK: - Private methods  
  
  /// Respond to a Right Click gesture
  ///
  /// - Parameter gr: the GestureRecognizer
  ///
  @objc private func rightClick(_ gr: NSClickGestureRecognizer) {
    var item: NSMenuItem!
    var index = 0
    
    // get the "click" coordinates and convert to this View
    let mouseLocation = gr.location(in: splitView)
    
    // create the popup menu
    let menu = NSMenu(title: "Panadapter")
    
    // calculate the frequency
    let mouseFrequency = Int(mouseLocation.x * _hzPerUnit) + _start
    
    // is the Frequency inside a Slice?
    let slice = xLib6000.Slice.find(with: _panadapter!.streamId, byFrequency: mouseFrequency, minWidth: Int( CGFloat(_bandwidth) * kSliceFindWidth ))
    if let slice = slice {
      
      // YES, mouse is in a Slice
      item = menu.insertItem(withTitle: kRemoveSlice, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.representedObject = slice
      item.target = self
      
    } else {
      
      // NO, mouse is not in a Slice
      item = menu.insertItem(withTitle: kCreateSlice, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.representedObject = NSNumber(value: mouseFrequency)
      item.target = self
    }
    
    // is the Frequency inside a Tnf?
    let tnf = Tnf.findBy(frequency: mouseFrequency, minWidth: Int( CGFloat(_bandwidth) * kTnfFindWidth ))
    if let tnf = tnf {
      // YES, mouse is in a TNF
      index += 1
      menu.insertItem(NSMenuItem.separator(), at: index)

      index += 1
      item = menu.insertItem(withTitle: tnf.frequency.hzToMhz + " MHz", action: #selector(noAction(_:)), keyEquivalent: "", at: index)

      index += 1
      item = menu.insertItem(withTitle: "Width: \(tnf.width) Hz", action: #selector(noAction(_:)), keyEquivalent: "", at: index)

      index += 1
      menu.insertItem(NSMenuItem.separator(), at: 4)
      
      index += 1
      item = menu.insertItem(withTitle: kRemoveTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.representedObject = tnf
      item.target = self
      
      index += 1
      menu.insertItem(NSMenuItem.separator(), at: 2)

      index += 1
      item = menu.insertItem(withTitle: kPermanentTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.state = tnf.permanent ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      index += 1
      item = menu.insertItem(withTitle: kNormalTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.state = (tnf.depth == Tnf.Depth.normal.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      index += 1
      item = menu.insertItem(withTitle: kDeepTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.state = (tnf.depth == Tnf.Depth.deep.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
      index += 1
      item = menu.insertItem(withTitle: kVeryDeepTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.state = (tnf.depth == Tnf.Depth.veryDeep.rawValue) ? NSControl.StateValue.on : NSControl.StateValue.off
      item.representedObject = tnf
      item.target = self
      
    } else {
      
      // NO, mouse is not in a TNF
      index += 1
      item = menu.insertItem(withTitle: kCreateTnf, action: #selector(contextMenu(_:)), keyEquivalent: "", at: index)
      item.representedObject = NSNumber(value: Float(mouseFrequency))
      item.target = self
    }
    
    // display the popup
    menu.popUp(positioning: menu.item(at: 0), at: mouseLocation, in: splitView)
    
  }
  /// Perform the appropriate action
  ///
  /// - Parameter sender: a MenuItem
  ///
  @objc private func contextMenu(_ sender: NSMenuItem) {
    
    switch sender.title {
      
    case kCreateSlice:        // tell the Radio to create a new Slice
      let freq = (sender.representedObject! as! NSNumber).intValue
      xLib6000.Slice.create(panadapter: _panadapter!, frequency: freq)
      
    case kRemoveSlice:        // tell the Radio to remove the Slice
     (sender.representedObject as! xLib6000.Slice).remove()
      
    case kCreateTnf:          // tell the Radio to create a new Tnf
      let freq = (sender.representedObject! as! NSNumber).intValue
      Tnf.create(frequency: freq.hzToMhz)
      
    case kRemoveTnf:          // tell the Radio to remove the Tnf
      let tnf = sender.representedObject as! Tnf
      tnf.remove()
      
    case kPermanentTnf:           // update the Tnf
      (sender.representedObject as! Tnf).permanent = !(sender.representedObject as! Tnf).permanent
      
    case kNormalTnf:              // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.normal.rawValue
      
    case kDeepTnf:                // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.deep.rawValue
      
    case kVeryDeepTnf:           // update the Tnf
      (sender.representedObject as! Tnf).depth = Tnf.Depth.veryDeep.rawValue
      
    default:
      break
    }
  }
  /// Perform the appropriate action
  ///
  /// - Parameter sender: a MenuItem
  ///
  @objc private func noAction(_ sender: NSMenuItem) {
  }
  /// Incr/decr the Slice frequency (scroll panafall at edges)
  ///
  /// - Parameters:
  ///   - slice: the Slice
  ///   - incr: frequency step
  ///
  private func adjustSliceFrequency(_ slice: xLib6000.Slice, incr: Int) {
    var isTooClose = false

    // is the existing frequency a multiple of the incr?
    if slice.frequency % incr == 0 {
      // YES, adjust the slice frequency by the incr value
      slice.frequency += incr

    } else {
      // NO, adjust to the nearest multiple of the incr
      var normalizedFreq = Double(slice.frequency) / Double(incr)
      if incr > 0 {
        // moving higher, adjust the slice frequency
        normalizedFreq.round(.toNearestOrAwayFromZero)
        
      } else {
        // moving lower, adjust the slice frequency
        normalizedFreq.round(.towardZero)
      }
      slice.frequency = Int(normalizedFreq * Double(incr))
    }
    // decide whether to move the panadapter center
    let center = ((slice.frequency + slice.filterHigh) + (slice.frequency + slice.filterLow))/2
    // moving which way?
    if incr > 0 {
      // UP, too close to the high end?
      isTooClose = center > _end - Int(PanafallViewController.kEdgeTolerance * CGFloat(_bandwidth))

    } else {
      // DOWN, too close to the low end?
      isTooClose = center + incr < _start + Int(PanafallViewController.kEdgeTolerance * CGFloat(_bandwidth))
    }
    // is the new freq too close to an edge?
    if isTooClose  {
      // YES, adjust the panafall center frequency (scroll the Panafall)
      _panadapter!.center += incr

      _panadapterViewController?.redrawFrequencyLegend()
    }
    // redraw all the slices
    _panadapterViewController?.redrawSlices()
  }
}
