#
#  Application.rb
#  Zap
#
#  Created by Nicholas Schlueter on 4/17/11.
#  Copyright 2011 Chalk. All rights reserved.
#


class RackApplication
    attr_accessor :symlink, :directory
    
    def rename(new_name)
        AppState.instance.rename_application(self, new_name)
    end
end