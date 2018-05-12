
# Anki Quick Word Adder
Anki is a free-mium software based on the concept of spaced repetition. It accelerates the process of learning by helping to retain information in the long-term memory.

The concept of utilizing Anki gets complicated when you encounter a difficult word while browsing on your computer. The flow is interrupted as you have to stop reading an article and add the word to Anki. This automates the process of adding the word, the sentence where you read the word quickly to Anki.
Additional features include retreiving meaning from oxford dictionary and images related to the word from two sources if available.
![screenshot](https://raw.githubusercontent.com/1nsp1r3rnzt/Anki-Quick-Word-Adder/master/images/picture.png)


## Getting Started

**steps**
Click the StartApp file to start the setup. **Please backup and sync Anki before proceeding.**
 
It installs the demo deck which has the 3 fields card type. Anki needed to be installed at demo location for the software to the word.

Then, you need to setup Oxford Dictionary API

```
Enter your api setting's in dictApi.ahk
;;;;;;;;;;;;;;;;;;;;;;;
global APP_ID:=""
global APP_KEY:=""
```
Finally run, StartApp.ahk to run the software.

press <key>`</key> to run the software.


### Prerequisites

Anki: [Anki Download](https://apps.ankiweb.net) 

 [Oxford Dictionary API](https://developer.oxforddictionaries.com)

[Google Chrome Dictionary Extension](https://chrome.google.com/webstore/detail/google-dictionary-by-goog/mgijmajocgfcbeboacabfgobmjgjcoja?hl=en) - optional



## Built With

* [Autohotkey](http://http://www.autohotkey.com) - The Scripting Language

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

*  [JSON Library](https://github.com/cocobelgica/AutoHotkey-JSON) by cocobelgica
* [WinClip Class](https://autohotkey.com/board/topic/74670-class-winclip-direct-clipboard-manipulations/) by Deo
* Images from WordWeb

