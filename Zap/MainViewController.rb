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
        reloadLinks
        self.listView.dataSource = self
    end
    
    def reloadLinks
        AppState.instance.refresh_applications
        self.application_controllers = AppState.instance.applications.collect do |a|
            application_controller = ApplicationViewController.new
            application_controller.application = a
            application_controller
        end
    end
    
    def numberOfItemsInListView(listView)
        application_controllers.count
    end
    
    def listView(listView, viewAtIndex:index)
        application_controllers[index].view
    end
end

