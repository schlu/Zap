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
        AppState.instance.refresh_applications
        self.listView.dataSource = self
    end
    
    def reloadLinks
        
        self.application_controllers = AppState.instance.applications.collect do |a|
            application_controller = ApplicationViewController.new
            application_controller.application = a
            application_controller
        end
    end
    
    def numberOfItemsInListView(listView)
        AppState.instance.applications.count
    end
    
    def listView(listView, viewAtIndex:index)
        applicationListItemView = ApplicationListItemView.itemView
        applicationListItemView.application = AppState.instance.applications[index]
        applicationListItemView
    end
end

