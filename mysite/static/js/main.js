$(document).ready(() => {
    $("[id^='cinema']").click((event) => {
        var cityID = event.target.attributes['data-city-id'].value;

        $.ajax({
            url: `http://localhost:8000/myapp/get_theatre_by_city_id?city_id=${cityID}`,
            method: 'GET',
            headers: {
                "x-csrf-token": $("input[name='csrfmiddlewaretoken']").val(),
                contentType: 'application/json',
            },
            
            success: (response) => {
                parsed = JSON.parse(response.cinemas);
                
                $("#result").html('');
                parsed.forEach(cinema=> {
                    var cinemaName = cinema.fields.all;
                    debugger
                    
                    
                    $("#result").append(`
                        <div style="float: left;">
                            <div class="card" style="width: 18rem;>
                                <a href="#">
                                    <img class="img-top-fluid"
                                        src="/media/${cinema.fields.image}"
                                        alt="">
                                </a>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a href="/myapp/${cinema.fields.url}">${cinema.fields.cinema}</a>
                                    </h4>
                                    <h5>${cinema.fields.city}</h5>
                                    <p class="card-text">${cinema.fields.address}</p>
                                </div>
                            </div>
                        </div>
                    `);
                    
                });
            },
            error: () => {
                alert("Ошибочка")
            }

        })

        // $.ajax({
        //     method: 'GET',
        //     url: `http://localhost:8000/myapp/get_theatre_by_city_id?city_id=${cityID}`,
        //     contentType: 'application/json',
        //     success: function(result){
        //         $('#result').html(result);
        //     }
        // })

    });
})