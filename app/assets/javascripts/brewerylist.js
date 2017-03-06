var BREWERIES = {};

BREWERIES.show = function(){
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function(index, brewery) {
        var string = "";

        if (brewery.active) {
            string = '<tr>' 
                      +'<td>' + brewery.name + '</td>'
                      +'<td>' + brewery.year + '</td>'
                      +'<td>' + brewery.beers.count + '</td>'
                      +'<td><span class="label label-success"> active </span> </td>'
                      +'</tr>';
        } else {
            string = '<tr>' 
                      +'<td>' + brewery.name + '</td>'
                      +'<td>' + brewery.year + '</td>'
                      +'<td>' + brewery.beers.count + '</td>'
                      +'<td><span class="label label-info"> retired </span> </td>'
                      +  '</tr>'; 
        }


        table.append(string);

               
    });

};

BREWERIES.sort_by_name = function() {
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};


BREWERIES.sort_by_year = function() {
    BREWERIES.list.sort( function(a,b){
        return a.year - b.year;
    });
};

BREWERIES.sort_by_beerCount = function() {
    BREWERIES.list.sort( function(a,b){
        return a.beers.count - b.beers.count 
    });
};

$(document).ready(function () {
    if ($("#brewerytable").length>0) {
        $("#name").click(function (e) {
            BREWERIES.sort_by_name();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#year").click(function (e) {
            BREWERIES.sort_by_year();
            BREWERIES.show();
            e.preventDefault();
        });


        $("#beerCount").click(function (e) {
            BREWERIES.sort_by_beerCount();
            BREWERIES.show();
            e.preventDefault();
        });

  

        $.getJSON('breweries.json', function (breweries) {
            BREWERIES.list = breweries;
            BREWERIES.show();
        });

    }
    
});
