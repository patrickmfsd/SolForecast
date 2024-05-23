//
//  Descriptions.swift
//  SolForecast
//
//  Created by Patrick Mifsud on 23/5/2024.
//

import Foundation

let aIndexDesc = "The A-index is an arithmetic mean of the eight daily a-index values where the a-index is the latitude adjusted amplitude equivalent (in nanoTesla) of the estimated K-index value. Indices with the subscript 'p' usually indicate 'planetary' index values, which have been generated using a standard set of observatories from around the world."

let kIndexDesc = "The estimated K-index for each station is derived from the H component (or D component) of the geo-magnetic field. After subtracting the local quiet background variation for a given location, the range of the variation in H (or D) over the 3-hour interval determines K. Whichever component, H or D, gives the largest variation in nT (nano Tesla), is assigned a value from 0 to 9 using a predetermined semi-logarithmic scale. Estimated K-indices generated for the Australian region are the average of the estimated K-indices from the individual stations and have a range of values 0 to 9."

let dstIndexDesc = "The Dst-index was derived to quantify the decrease in the geomagnetic field H-component observed during the main phase of magnetic storms produced mainly by the equatorial current system in the magnetosphere referred to as the ring current. An Australian region Dst-index, AusDst, is produced by averaging individual station Dst values from low-mid latitude stations in Australia. The Dst-index values are mapped to the following colours: green for 'No Storm: Dst > -20 nT', yellow for 'Weak Storm: Dst < -20 nT', orange for 'Moderate Storm: Dst < -50 nT', red for 'Strong Storm: Dst < -100 nT', and dark red for 'Severe Storm: Dst < -200 nT'."

let auroraDesc = "Aurora alerts are issued whenever the Australian region estimated K-index reaches 6 or greater. When an alert is current the alert information indicates the latitudinal range in terms of high, middle, low and equatorial regions where aurora may be visible under good observing conditions."


