#
#  MainViewController.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 Chalk. All rights reserved.
#

class MainViewController < NSViewController
    attr_accessor :application_controllers, :listView
    def init
        if super
            initWithNibName "MainViewController", bundle:nil
            self.application_controllers = []
        end
        self
    end
    
    def loadView
        super
        if AppState.instance.pow_installed?
            self.setup_links
            self.listView.dataSource = self
        else
            alert = NSAlert.alertWithMessageText("Pow not installed", defaultButton:"Continue", alternateButton:"Cancel", otherButton:nil, informativeTextWithFormat:"Zap requires Pow. Go to http://pow.cx for instructions")
            if alert.runModal == NSAlertDefaultReturn
                url = NSURL.URLWithString("http://pow.cx/")
                NSWorkspace.sharedWorkspace.openURL(url)
            end
            NSApplication.sharedApplication.terminate(self)
        end
    end
    
    def setup_links
        AppState.instance.refresh_applications
        listView.reloadData
    end
    
    def numberOfItemsInListView(listView)
        AppState.instance.applications.count + 1
    end
    
    def listView(listView, viewAtIndex:index)
        if index == 0
            ApplicationListHeaderView.headerView
        else
            applicationListItemView = ApplicationListItemView.itemView
            applicationListItemView.application = AppState.instance.applications[index-1]
            applicationListItemView
        end
    end
end

