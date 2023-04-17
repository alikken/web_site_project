$(document).ready(() => {
    $("[id^='cinema']").click((event) => {
        var cityID = event.target.attributes['data-city-id'].value;
 
        $.ajax({
            url: `http://192.168.1.6:8000/get_theatre_by_city_id?city_id=${cityID}`,
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

                        <a href="/${cinema.url}" class="text-decoration-none text-black ">
                            <div class="container-sm">
                                <div class="card border border-0" style="width: 32rem; height: 7rem;">
                                    <div class="card-body" >
                                        <div class="row row-cols-auto">
                                            <div class="col">
                                                <img class="img-cinema card-img rounded" src="${cinema.image}" alt="">
                                            </div>
                                            <div class="col">
                                                <p class="fw-medium">${cinema.cinema}|${cinema.city}</p>
                                                <p>${cinema.address}</p>
                                            </div>
                                        </div>  
                                    </div>
                                </div>
                            </div>
                        </a>


                    `);
                });
            },
            error: () => {
                alert("Ошибочка")
            }
        })



    });
    var hallID = $("#hallID").val();
    debugger
    $.ajax({
        url: `http://localhost:8000/get_seats_by_hall/${hallID}`,
        type: 'GET',
        success: (response) => {
            for (let row = 0; row < response.seats.length; i++) {
                var eachRow = response.seats[row];
                for (let col = 0; col < eachRow.length; col++) {
                    var element = eachRow[col];
                    // шаблон append
                    $("#seatsList").append(`
                        
                    `)
                }
            }
        },
    })
})