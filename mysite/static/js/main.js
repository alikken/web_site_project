$(document).ready(() => {
    $("[id^='cinema']").click((event) => {
        var cityID = event.target.attributes['data-city-id'].value;
 
        $.ajax({
            url: `/get_theatre_by_city_id?city_id=${cityID}`,
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
                                                <img class="img-cinema card-img rounded" src="${cinema.image}" width="75" height="75">
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



// // Новый ajax
//     $("[id]").click((event) => {
//     var hallID = event.target.attributes['data-hall-id'].value;

    
//     $.ajax({
//         url: `http://172.16.59.6:8000/get_seats_by_hall/${hallID}`,
//         type: 'GET',
//         headers: {
//             "x-csrf-token": $("input[name='csrfmiddlewaretoken']").val(),
//             contentType: 'application/json',
//         },
//         success: (response) => {
//             var seatsDiv = $("div");

//             response.forEach((hall)=> {
                
//                 seatsDiv.append(`<input type="checkbox" value="${hall.fields}">`)
//             });
            
//             // $("#mainDiv").append(seatsDiv);
//             $("#exampleModal").show();
//         },
//         error: () => {
//             alert("Ошибочка")
//         }
//     })
//     });
})





  