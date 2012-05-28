$(document).ready(function() {
    $('#po').autocomplete({
        url: '/vendor?autopo=',
        minChars: 1,
        max: 10,
        width: 150,
        scroll: false
    });
    $('#city').autocomplete({
        url: '/vendor?autovendor=',
        minChars: 1,
        max: 10,
        width: 150,
        scroll: false
    });
})
