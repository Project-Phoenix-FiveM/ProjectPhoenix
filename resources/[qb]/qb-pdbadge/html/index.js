window.addEventListener('message', (event) => {
    const data = event.data;
    
    if (data.type === 'badge') {
        document.getElementById('badge').style.display = "block"
        document.getElementById('name').textContent = data.name.substring(0, 20)
        document.getElementById('rank').textContent = data.rank.substring(0, 20)
        document.getElementById('callsign').textContent = data.callsign.substring(0, 20)
        document.getElementById("headshot").src=data.url;
        document.getElementById("badgeimg").src="./images/" + data.dept + ".png";
    }
    
    if (data.type === 'close') {
        document.getElementById('badge').style.display = "none"
    }
});
