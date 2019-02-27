//
//  ReduxMacro.h
//  Pods
//
//  Created by bob on 2019/2/27.
//

#ifndef ReduxMacro_h
#define ReduxMacro_h

#define ReduxWeakSelf __weak typeof(self) wself = self
#define ReduxStrongSelf __strong typeof(wself) self = wself


#endif /* ReduxMacro_h */
