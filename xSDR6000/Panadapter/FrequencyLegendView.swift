//
//  FrequencyLegendView.swift
//  xSDR6000
//
//  Created by Douglas Adams on 9/30/17.
//  Copyright © 2017 Douglas Adams. All rights reserved.
//

import Cocoa
import xLib6000
import SwiftyUserDefaults

public final class FrequencyLegendView      : NSView {
  
  typealias BandwidthParamTuple = (high: Int, low: Int, spacing: Int, format: String)
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal properties
  
  var radio: Radio?                         = Api.sharedInstance.radio
  weak var panadapter                       : Panadapter?
  
  var flags                                 = [FlagViewController]()
  var legendHeight                          : CGFloat = 20                  // height of legend area
  var font                                  = NSFont(name: "Monaco", size: 12.0)
  var markerHeight                          : CGFloat = 0.6                 // height % for band markers
  var shadingPosition                       : CGFloat = 21
  
  // ----------------------------------------------------------------------------
  // MARK: - Private properties


  
  private var _center                       : Int {return panadapter!.center }
  private var _bandwidth                    : Int { return panadapter!.bandwidth }
  private var _start                        : Int { return _center - (_bandwidth/2) }
  private var _end                          : Int  { return _center + (_bandwidth/2) }
  private var _hzPerUnit                    : CGFloat { return CGFloat(_end - _start) / self.frame.width }
  
  private var _bandwidthParam               : BandwidthParamTuple {  // given Bandwidth, return a Spacing & a Format
    get { return kBandwidthParams.filter { $0.high > _bandwidth && $0.low <= _bandwidth }.first ?? kBandwidthParams[0] } }
  
  private var _attributes                   = [NSAttributedStringKey:AnyObject]() // Font & Size for the Frequency Legend
  private var _path                         = NSBezierPath()
  
  private let kBandwidthParams: [BandwidthParamTuple] =                     // spacing & format vs Bandwidth
    [   //      Bandwidth               Legend
      //  high         low      spacing   format
      (15_000_000, 10_000_000, 1_000_000, "%0.0f"),           // 15.00 -> 10.00 Mhz
      (10_000_000,  5_000_000,   400_000, "%0.1f"),           // 10.00 ->  5.00 Mhz
      ( 5_000_000,   2_000_000,  200_000, "%0.1f"),           //  5.00 ->  2.00 Mhz
      ( 2_000_000,   1_000_000,  100_000, "%0.1f"),           //  2.00 ->  1.00 Mhz
      ( 1_000_000,     500_000,   50_000, "%0.2f"),           //  1.00 ->  0.50 Mhz
      (   500_000,     400_000,   40_000, "%0.2f"),           //  0.50 ->  0.40 Mhz
      (   400_000,     200_000,   20_000, "%0.2f"),           //  0.40 ->  0.20 Mhz
      (   200_000,     100_000,   10_000, "%0.2f"),           //  0.20 ->  0.10 Mhz
      (   100_000,      40_000,    4_000, "%0.3f"),           //  0.10 ->  0.04 Mhz
      (    40_000,      20_000,    2_000, "%0.3f"),           //  0.04 ->  0.02 Mhz
      (    20_000,      10_000,    1_000, "%0.3f"),           //  0.02 ->  0.01 Mhz
      (    10_000,       5_000,      500, "%0.4f"),           //  0.01 ->  0.005 Mhz
      (    5_000,            0,      400, "%0.4f")            //  0.005 -> 0 Mhz
  ]
  private let _frequencyLineWidth           : CGFloat = 2.0
  private let _lineColor                    = NSColor(srgbRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.2)
  
  // band & markers
  private lazy var _segments                = Band.sharedInstance.segments

  private let kMultiplier                   : CGFloat = 0.001
  private let kFlagBorder                   : CGFloat = 20

  // ----------------------------------------------------------------------------
  // MARK: - Overridden methods
  
  public override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
    // set the background color
    layer?.backgroundColor = NSColor.clear.cgColor
    
    drawSlices()
    
    positionFlags()

    drawTnfs()

    // draw the Frequency legend and vertical grid lines
    drawLegend(dirtyRect)

    // draw band markers (if shown)
    if Defaults[.showMarkers] { drawBandMarkers() }    
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Internal methods
  
  /// Process a bandwidth drag
  ///
  /// - Parameter dr:         the draggable
  ///
  func updateBandwidth(dragable dr: PanadapterViewController.Dragable) {
    
    // CGFloat versions of params
    let end = CGFloat(_end)                     // end frequency (Hz)
    let start = CGFloat(_start)                 // start frequency (Hz)
    let bandwidth = CGFloat(_bandwidth)         // bandwidth (hz)
    
    // calculate the % change, + = greater bw, - = lesser bw
    let delta = ((dr.previous.x - dr.current.x) / frame.width)
    
    // calculate the new bandwidth (Hz)
    let newBandwidth = (1 + delta) * bandwidth
    
    // calculate adjustments to start & end
    let adjust = (newBandwidth - bandwidth) / 2.0
    let newStart = start - adjust
    let newEnd = end + adjust
    
    // calculate adjustment to the center
    let newStartPercent = (dr.frequency - newStart) / newBandwidth
    let freqError = (newStartPercent - dr.percent) * newBandwidth
    let newCenter = (newStart + freqError) + (newEnd - newStart) / 2.0
    
    // adjust the center & bandwidth values (Hz)
    panadapter!.center = Int(newCenter)
    panadapter!.bandwidth = Int(newBandwidth)
    
    // redraw the frequency legend
    redraw()
  }
  /// Process a center frequency drag
  ///
  /// - Parameter dr:       the draggable
  ///
  func updateCenter(dragable dr: PanadapterViewController.Dragable) {
    
    // adjust the center
    panadapter!.center = panadapter!.center - Int( (dr.current.x - dr.previous.x) * _hzPerUnit)
    
    // redraw the frequency legend
    redraw()
  }
  /// Process a Tnf drag
  ///
  /// - Parameter dr:         the draggable
  ///
  func updateTnf(dragable dr: PanadapterViewController.Dragable) {
    
    // calculate offsets in x & y
    let deltaX = dr.current.x - dr.previous.x
    let deltaY = dr.current.y - dr.previous.y
    
    // is there a tnf object?
    if let tnf = dr.object as? Tnf {
      
      // YES, drag or resize?
      if abs(deltaX) > abs(deltaY) {
        
        // drag
        tnf.frequency = Int(dr.current.x * _hzPerUnit) + _start
      } else {
        
        // resize
        tnf.width = tnf.width + Int(deltaY * CGFloat(_bandwidth) * kMultiplier)
      }
    }
    // redraw the tnfs
    redraw()
  }
  /// Process a Slice drag
  ///
  /// - Parameter dr:         the draggable
  ///
  func updateSlice(dragable dr: PanadapterViewController.Dragable) {
    
    // calculate offsets in x & y
    let deltaX = dr.current.x - dr.previous.x
    let deltaY = dr.current.y - dr.previous.y
    
    // is there a slice object?
    if let slice = dr.object as? xLib6000.Slice {
      
      // YES, drag or resize?
      if abs(deltaX) > abs(deltaY) {
        
        // drag
        slice.frequency += Int(deltaX * _hzPerUnit)
        
      } else {
        
        // resize
        slice.filterLow -= Int(deltaY * CGFloat(_bandwidth) * kMultiplier)
        slice.filterHigh += Int(deltaY * CGFloat(_bandwidth) * kMultiplier)
      }
    }
    // redraw the slices
    redraw()
  }
  /// Force the view to be redrawn
  ///
  func redraw() {
    
    // interact with the UI
    DispatchQueue.main.async {
      // force a redraw
      self.needsDisplay = true
    }
  }
  
  // ----------------------------------------------------------------------------
  // MARK: - Private methods
  
  private func drawLegend(_ dirtyRect: NSRect) {
    
    // setup the Frequency Legend font & size
    _attributes[NSAttributedStringKey.foregroundColor] = Defaults[.frequencyLegend]
    _attributes[NSAttributedStringKey.font] = font

    let bandwidthParams = kBandwidthParams.filter { $0.high > _bandwidth && $0.low <= _bandwidth }.first ?? kBandwidthParams[0]
    let xIncrPerLegend = CGFloat(bandwidthParams.spacing) / _hzPerUnit

    // calculate the number & position of the legend marks
    let numberOfMarks = (_end - _start) / bandwidthParams.spacing
    let firstFreqValue = _start + bandwidthParams.spacing - (_start - ( (_start / bandwidthParams.spacing) * bandwidthParams.spacing))
    let firstFreqPosition = CGFloat(firstFreqValue - _start) / _hzPerUnit

    // remember the position of the previous legend (left to right)
    var previousLegendPosition: CGFloat = 0.0

    NSColor.black.set()
    NSBezierPath.fill(NSRect(x: 0.0, y: 0.0, width: frame.width, height: 20.0))
    
    // make the line solid
    var dash: [CGFloat] = [2.0, 0.0]
    _path.lineWidth = CGFloat(0.5)
    _path.setLineDash( dash, count: 2, phase: 0 )

    // horizontal line above legend
    Defaults[.frequencyLegend].set()
    _path.hLine(at: legendHeight, fromX: 0, toX: frame.width)

    // draw legends
    for i in 0...numberOfMarks {
      let xPosition = firstFreqPosition + (CGFloat(i) * xIncrPerLegend)

      // calculate the Frequency legend value & width
      let legendLabel = String(format: bandwidthParams.format, ( CGFloat(firstFreqValue) + CGFloat( i * bandwidthParams.spacing)) / 1_000_000.0)
      let legendWidth = legendLabel.size(withAttributes: _attributes).width

      // skip the legend if it would overlap the start or end or if it would be too close to the previous legend
      if xPosition > 0 && xPosition + legendWidth < frame.width && xPosition - previousLegendPosition > 1.2 * legendWidth {
        // draw the legend
        legendLabel.draw(at: NSMakePoint( xPosition - (legendWidth/2), 1), withAttributes: _attributes)
        // save the position for comparison when drawing the next legend
        previousLegendPosition = xPosition
      }
    }
    _path.strokeRemove()
    
    //        let legendHeight = "123.456".size(withAttributes: _attributes).height
    
    // set Line Width, Color & Dash
    _path.lineWidth = CGFloat(Defaults[.gridLineWidth])
    dash = Defaults[.gridLinesDashed] ? [2.0, 1.0] : [2.0, 0.0]
    _path.setLineDash( dash, count: 2, phase: 0 )
    Defaults[.gridLines].set()
    
    // draw vertical grid lines
    for i in 0...numberOfMarks {
      let xPosition = firstFreqPosition + (CGFloat(i) * xIncrPerLegend)
      
      // draw a vertical line at the frequency legend
      if xPosition < bounds.width {
        _path.vLine(at: xPosition, fromY: bounds.height, toY: legendHeight)
      }
      // draw an "in-between" vertical line
      _path.vLine(at: xPosition + (xIncrPerLegend/2), fromY: bounds.height, toY: legendHeight)
    }
    _path.strokeRemove()
  }
  
  /// Draw the Band Markers
  ///
  private func drawBandMarkers() {
    // use solid lines
    _path.setLineDash( [2.0, 0.0], count: 2, phase: 0 )
    
    // filter for segments that overlap the panadapter frequency range
    let overlappingSegments = _segments.filter {
      (($0.start >= _start || $0.end <= _end) ||    // start or end in panadapter
        $0.start < _start && $0.end > _end) &&    // start -> end spans panadapter
        $0.enabled && $0.useMarkers}                                    // segment is enabled & uses Markers
    
    // ***** Band edges *****
    Defaults[.bandEdge].set()  // set the color
    _path.lineWidth = 1         // set the width
    
    // filter for segments that contain a band edge
    let edgeSegments = overlappingSegments.filter {$0.startIsEdge || $0.endIsEdge}
    for s in edgeSegments {
      
      // is the start of the segment a band edge?
      if s.startIsEdge {
        
        // YES, draw a vertical line for the starting band edge
        _path.vLine(at: CGFloat(s.start - _start) / _hzPerUnit, fromY: frame.height * markerHeight, toY: 0)
        _path.drawX(at: NSPoint(x: CGFloat(s.start - _start) / _hzPerUnit, y: frame.height * markerHeight), halfWidth: 6)
      }
      
      // is the end of the segment a band edge?
      if s.endIsEdge {
        
        // YES, draw a vertical line for the ending band edge
        _path.vLine(at: CGFloat(s.end - _start) / _hzPerUnit, fromY: frame.height * markerHeight, toY: 0)
        _path.drawX(at: NSPoint(x: CGFloat(s.end - _start) / _hzPerUnit, y: frame.height * markerHeight), halfWidth: 6)
      }
    }
    _path.strokeRemove()
    
    // ***** Inside segments *****
    Defaults[.segmentEdge].set()        // set the color
    _path.lineWidth = 1         // set the width
    var previousEnd = 0
    
    // filter for segments that contain an inside segment
    let insideSegments = overlappingSegments.filter {!$0.startIsEdge && !$0.endIsEdge}
    for s in insideSegments {
      
      // does this segment overlap the previous segment?
      if s.start != previousEnd {
        
        // NO, draw a vertical line for the inside segment start
        _path.vLine(at: CGFloat(s.start - _start) / _hzPerUnit, fromY: frame.height * markerHeight - 6/2 - 1, toY: 0)
        _path.drawCircle(at: NSPoint(x: CGFloat(s.start - _start) / _hzPerUnit, y: frame.height * markerHeight), radius: 6)
      }
      
      // draw a vertical line for the inside segment end
      _path.vLine(at: CGFloat(s.end - _start) / _hzPerUnit, fromY: frame.height * markerHeight - 6/2 - 1, toY: 0)
      _path.drawCircle(at: NSPoint(x: CGFloat(s.end - _start) / _hzPerUnit, y: frame.height * markerHeight), radius: 6)
      previousEnd = s.end
    }
    _path.strokeRemove()
    
    // ***** Band Shading *****
    Defaults[.bandMarker].set()
    for s in overlappingSegments {
      
      // calculate start & end of shading
      let start = (s.start >= _start) ? s.start : _start
      let end = (_end >= s.end) ? s.end : _end
      
      // draw a shaded rectangle for the Segment
      let rect = NSRect(x: CGFloat(start - _start) / _hzPerUnit, y: shadingPosition, width: CGFloat(end - start) / _hzPerUnit, height: 20)
      NSBezierPath.fill(rect)
    }
    _path.strokeRemove()
  }
  
  func drawSlices() {
    
    for (_, slice) in radio!.slices where slice.panadapterId == panadapter!.id {
        
        drawFilterOutline(slice)
        
        drawFrequencyLine(slice)
    }
  }
  /// Position Slice flags
  ///
  private func positionFlags() {
    var frequencyPosition = NSPoint(x: 0.0, y: 0.0)
    var onLeft = true
    var spacing : CGFloat = 0.0
    
    // sort the Flags from left to right
    let sortedFlags = flags.sorted {$0.slice!.frequency < $1.slice!.frequency}
    
    var previousFlagVc : FlagViewController?
    for currentFlagVc in sortedFlags {
      
      // is this the first Flag?
      if previousFlagVc == nil {
        
        // YES, it's the first one (always on the left)
        onLeft = true
        
        // calculate the minimum spacing between flags
        spacing = currentFlagVc.view.frame.width + kFlagBorder
        
      } else {
        
        let previousFrequencyPosition = CGFloat(previousFlagVc!.slice!.frequency - _start) / _hzPerUnit
        let currentFrequencyPosition = CGFloat(currentFlagVc.slice!.frequency - _start) / _hzPerUnit
        
        // determine the needed spacing between flags
        let currentSpacing = previousFlagVc!.onLeft ? spacing : 2 * spacing
        
        // is this Flag too close to the previous one?
        if currentFrequencyPosition - previousFrequencyPosition < currentSpacing {
          
          // YES, put it on the right
          onLeft = false
          
        } else {
          
          // NO, put it on the left
          onLeft = true
        }
      }
      // calculate the X & Y positions of the flags
      frequencyPosition.x = CGFloat(currentFlagVc.slice!.frequency - _start) / _hzPerUnit
      frequencyPosition.y = frame.height - currentFlagVc.view.frame.height
      
      // position it
      currentFlagVc.moveTo( frequencyPosition, onLeft: onLeft)
      
      // make the current one the previous one
      previousFlagVc = currentFlagVc
    }
  }

  /// Draw the Filter Outline
  ///
  /// - Parameter slice:  this Slice
  ///
  fileprivate func drawFilterOutline(_ slice: xLib6000.Slice) {
    
    // calculate the Filter position & width
    let _filterPosition = CGFloat(slice.filterLow + slice.frequency - _start) / _hzPerUnit
    let _filterWidth = CGFloat(slice.filterHigh - slice.filterLow) / _hzPerUnit
    
    // draw the Filter
    let _rect = NSRect(x: _filterPosition, y: 0, width: _filterWidth, height: frame.height)
    _path.fillRect( _rect, withColor: Defaults[.sliceFilter], andAlpha: 0.5)
    
    _path.strokeRemove()
  }
  /// Draw the Frequency line
  ///
  /// - Parameter slice:  this Slice
  ///
  fileprivate func drawFrequencyLine(_ slice: xLib6000.Slice) {
    
    // make the line solid
    let dash: [CGFloat] = [2.0, 0.0]
    _path.setLineDash( dash, count: 2, phase: 0 )

    // set the width & color
    _path.lineWidth = _frequencyLineWidth
    if slice.active { Defaults[.sliceActive].set() } else { Defaults[.sliceInactive].set() }
    
    // calculate the position
    let _freqPosition = ( CGFloat(slice.frequency - _start) / _hzPerUnit)
    
    // create the Frequency line
    _path.move(to: NSPoint(x: _freqPosition, y: frame.height))
    _path.line(to: NSPoint(x: _freqPosition, y: 0))
    
    // add the triangle cap (if active)
    if slice.active { _path.drawTriangle(at: _freqPosition, topWidth: 15, triangleHeight: 15, topPosition: frame.height) }
    
    _path.strokeRemove()
  }
  /// Draw the outline of tnf(s)
  ///
  fileprivate func drawTnfs() {
    // for each Tnf
    for (_, tnf) in radio!.tnfs {
      
      // is it on this panadapter?
      if tnf.frequency >= _start && tnf.frequency <= _end {
        
        // YES, calculate the position & width
        let tnfPosition = CGFloat(tnf.frequency - tnf.width/2 - _start) / _hzPerUnit
        let tnfWidth = CGFloat(tnf.width) / _hzPerUnit
        
        // draw the rectangle
        let rect = NSRect(x: tnfPosition, y: 0, width: tnfWidth, height: frame.height)
        
        _path.fillRect( rect, withColor: radio!.tnfEnabled ? Defaults[.tnfActive] : Defaults[.tnfInactive])
        
        // crosshatch it based on depth
        _path.crosshatch(rect, color: _lineColor, depth: tnf.depth, twoWay: true)
        
        // is it "permanent"?
        if tnf.permanent {

          // YES, highlight it
          NSColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5).set()
          _path.appendRect(rect)
        }
        _path.strokeRemove()
      }
    }
  }

}