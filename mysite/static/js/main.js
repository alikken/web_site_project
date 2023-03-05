$(document).ready(() => {
    $("[id^='cinema']").click((event) => {
        var cityID = event.target.attributes['data-city-id'].value;
        alert(cityID);

        $.ajax({
            url: `http://localhost:8000/myapp/get_theatre_by_city_id?city_id=${cityID}`,
            method: 'GET',
            contentType: 'application/json',
            success: (response) => {
                parsed = JSON.parse(response.cinemas);
                parsed.forEach(cinema => {
                    var name = cinema.model;
                    debugger
                });
                debugger
            },
            error: () => {
                alert("Ошибочка")
            }

        })
    });
})