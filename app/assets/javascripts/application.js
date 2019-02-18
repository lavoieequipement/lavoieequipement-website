// This is a manifest file that'll be compiled into application.js, which will include all the files
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require foundation
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    $(document).foundation();

    $(window).trigger('load.zf.sticky');



        $(function() {
          $(window).scroll(function() {
            var winTop = $(window).scrollTop();
            if (winTop >= 69) {
              $("header").addClass("sticky-header");
            } else{
              $("header").removeClass("sticky-header");
            }
          });
        });

        function initializeAutocomplete(id) {
        var element = document.getElementById(id);
        if (element) {
          var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'], componentRestrictions: {country: ['ca','us']} });
          google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
        }
      }

      function onPlaceChanged() {
        var place = this.getPlace();

        // console.log(place);  // Uncomment this line to view the full object returned by Google API.

        for (var i in place.address_components) {
          var component = place.address_components[i];
          for (var j in component.types) {  // Some types are ["country", "political"]
            var type_element = document.getElementById(component.types[j]);
            if (type_element) {
              type_element.value = component.long_name;
            }
          }
        }
      }

      google.maps.event.addDomListener(window, 'load', function() {
        initializeAutocomplete('autocomplete_start_address');
        initializeAutocomplete('autocomplete_end_address');
      });

      // LISTES DEROULANTES DYNAMIQUES
    $('#equipment_brand_id').change(function(){
        var brand_id = this.value
        if(brand_id != "undefined" && brand_id != 0)
        {
            $.ajax({
                url : "/configuration/values/brands/list_brand_models/"+brand_id,
            })
        }
    });


});
