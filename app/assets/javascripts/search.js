document.addEventListener("turbolinks:load", function() {
    $input = $("[data-behavior='autocomplete']")
  
    var options = {
      getValue: function(element) {
          return element.name;
      },
      template: {
		type: "custom",
		method: function(value, item) {
            return "<span style ='font-size:15px;'>" + value + "</span>"
            + "<span style='color: #aaa;font-style: italic;font-size: 13px;'> - " 
            + item.zone 
            + "</br><span class='glyphicon glyphicon-map-marker' aria-hidden='true'></span> " 
            + item.address + '</span>';
		}
	  },
      url: function(phrase) {
        return "/search.json?q=" + phrase;
      },
      
      categories: [
        {
            listLocation: "motels",
        }

      ],
      list: {
        onChooseEvent: function() {
          var url = $input.getSelectedItemData().url
          $input.val("")
          Turbolinks.visit(url)
        }
      },
      theme: "plate-dark"
    };
  
    $("#test").easyAutocomplete(options)
  });