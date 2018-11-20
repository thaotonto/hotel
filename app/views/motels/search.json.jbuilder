json.motels @motels do |motel|
        json.name motel.name 
        json.address motel.address
        json.zone motel.zone
        json.url motel_path(motel)
end





