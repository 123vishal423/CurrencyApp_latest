//
//  PackageBundlePathLoader.swift
//  AAInfographicsDemo
//
//  Created by Aleksandar VaciÄ on 2020/12/15.
//  Copyright Â© 2022 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 *  ð ð ð ð  âââ   WARM TIPS!!!   âââ ð ð ð ð
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit-Swift/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

import Foundation

class BundlePathLoader {
    func path(
        forResource name: String,
        ofType fileType: String,
        inDirectory subpath: String? = nil,
        forLocalization localizationName: String? = nil
    ) -> String? {
        return Bundle(for: type(of: self)).path(
            forResource: name,
            ofType: fileType,
            inDirectory: subpath,
            forLocalization: localizationName
        )
    }
}
