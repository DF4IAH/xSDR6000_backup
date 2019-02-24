//
//  PreferencesTabViewController.swift
//  xSDR6000
//
//  Created by Douglas Adams on 11/16/16.
//  Copyright © 2016 Douglas Adams. All rights reserved.
//

import Cocoa
import os.log
import xLib6000
import SwiftyUserDefaults

// ----------------------------------------------------------------------------
// MARK: - Overrides

final class PreferencesTabViewController    : NSTabViewController {
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties
  
  private let _autosaveName                 = "PreferencesWindow"
  private let _log                          = OSLog(subsystem: Api.kDomainId + "." + kClientName, category: "Preferences")
  
  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    #if DEBUG
    Swift.print("\(#function) - \(URL(fileURLWithPath: #file).lastPathComponent.dropLast(6))")
    #endif
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    // select the previously selelcted tab
    tabView.selectTabViewItem(withIdentifier: NSUserInterfaceItemIdentifier(Defaults[.preferencesTabId]) )

    os_log("Preferences window opened", log: self._log, type: .info)
  }

  override func viewWillAppear() {
    super.viewWillAppear()
    
    view.window!.setFrameUsingName(_autosaveName)
    view.window!.level = .floating

    // select the previously displayed tab
    tabView.selectTabViewItem(withIdentifier: NSUserInterfaceItemIdentifier(Defaults[.preferencesTabId]) )
  }
  
  override func viewWillDisappear() {
    super.viewWillDisappear()
    
    view.window!.saveFrame(usingName: _autosaveName)

    // close the ColorPicker (if open)
    if NSColorPanel.shared.isVisible {
      NSColorPanel.shared.performClose(nil)
    }
    // save the currently displayed tab
    Defaults[.preferencesTabId] = (tabView.selectedTabViewItem?.identifier as! NSUserInterfaceItemIdentifier).rawValue
  }

  override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
    super.tabView(tabView, willSelect: tabViewItem)

    // close the ColorPicker (if open)
    if NSColorPanel.shared.isVisible {
      NSColorPanel.shared.performClose(nil)
    }
  }
  deinit {
    os_log("Preferences window closed", log: self._log, type: .info)
    #if DEBUG
    Swift.print("\(#function) - \(URL(fileURLWithPath: #file).lastPathComponent.dropLast(6))")
    #endif
  }

  // ----------------------------------------------------------------------------
  // MARK: - Action methods
  
//  /// Respond to the Quit menu item
//  ///
//  /// - Parameter sender:     the button
//  ///
//  @IBAction func quitRadio(_ sender: AnyObject) {
//
//    dismiss(sender)
//
//    // perform an orderly shutdown of all the components
//    Api.sharedInstance.shutdown(reason: .normal)
//
//    DispatchQueue.main.async {
//      os_log("Application closed by user", log: self._log, type: .info)
//
//      NSApp.terminate(self)
//    }
//  }
}

