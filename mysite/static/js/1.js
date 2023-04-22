
$(document).ready(function(){
    var owl = $('.owl-carousel');
    $('.owl-carousel').owlCarousel({
        loop:true,
        stagePadding: 50,
        margin:10,
        nav:true,
        dots: false,
        navText: [
            "<ion-icon name='arrow-back-outline'></ion-icon>", // иконка стрелки влево
            "<ion-icon name='arrow-forward-outline'></ion-icon>" // иконка стрелки вправо
        ],
        responsive:{
            0:{
                items:1
            },
            600:{
                items:3
            },
            1000:{
                items:7
            }
        }
    });
    owl.on('translated.owl.carousel', function(event) {
        var current = event.item.index;
        var items = event.item.count;
        var isBeginning = current == 0;
        if (isBeginning) {
            $('.owl-prev').hide();
          } else {
            $('.owl-prev').show();
          }
    });
});