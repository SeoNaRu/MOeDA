function getCurrentLocation() {
    console.log("이벤트 실행");
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var location = {
                latitude: position.coords.latitude,
                longitude: position.coords.longitude
            };
            // 전달할 이벤트 생성
            var event = new CustomEvent('location', { detail: JSON.stringify(location) });
            // 이벤트 디스패치
            window.dispatchEvent(event);
        });
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}
