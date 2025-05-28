fetch('https://9uzaj7kq49.execute-api.us-east-1.amazonaws.com/default/visitorcounter')
    .then(response => response.json())
    .then(data => {
    document.getElementById("visitorcounter").textContent = data["visitorcount"];
  })