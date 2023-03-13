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
                console.log(response)
                
                
                

                
                $("#result").html('');
                response.forEach(cinema=> {
                    
                    $("#result").append(`
                        <div style="float: left;">
                            <div class="card" style="width: 18rem;>
                                <a href="#">
                                    <img class="img-top-fluid"
                                        src="${cinema.image}"
                                        alt="">
                                </a>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a href="/myapp/${cinema.url}">${cinema.cinema}</a>
                                    </h4>
                                    <h5>${cinema.city}</h5>
                                    <p class="card-text">${cinema.address}</p>
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