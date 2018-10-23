class StaticPagesController < ApplicationController
    def home 
        @motels= Motel.all
    end
end
