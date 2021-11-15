# BrokenMultipleListSelection

Demonstrates how having a Context Menu on a NavigationLink breaks the lists multiple selection.

**System Info:**
* Xcode 13.1 (13A1030d)
* iPad Pro 11 (2018, iOS 15.1)
* iPhone 13 Simulator


**Reproduction steps:**
1. Run app on an iPhone in the simulator
2. In "working" mode, hit "Edit"
3. Start selecting items
4. Hit "Done"
5. Change to "broken" mode
6. Hit "Edit"
7. Start selecting items


**Actual Results:**
In "working" mode, the selection works properly. In "broken" mode, you can see the list flicker when items are selected and then the highlight state disappears.

This is caused by having the list items wrapped in a NavigationLink with a Context Menu.


https://user-images.githubusercontent.com/42879920/141809398-494df7c0-5072-46f5-9541-0c4103d92842.mp4



**Expected Results:**
Both modes should work as it does in "working" mode.
