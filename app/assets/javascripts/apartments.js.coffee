$ ->
  map = L.map('map').setView([51.505, -0.09], 13)

  L.tileLayer('http://{s}.tiles.mapbox.com/v3/yoyostile.j66f39do/{z}/{x}/{y}.png', {
      attribution: "<a href='https://www.mapbox.com/about/maps/' target='_blank'>Maps &copy; Mapbox &copy; OpenStreetMap</a>",
      maxZoom: 16,
      detectRetina: true
  }).addTo(map)

  # L.marker([51.5, -0.09]).addTo(map)
  #     .bindPopup('A pretty CSS3 popup. <br> Easily customizable.')
  #     .openPopup();


  apartments = $('#map').data('apartments')
  markers = []
  points = []
  for result in apartments
    marker = L.marker([result.latitude, result.longitude])
    pop = L.popup({ 'className': 'box' }).setContent(
      "<h3>ID: #{result.is24_id}</h3>
      Address: #{result.address}
      <br>
      size: #{result.size}
      <br>
      rent: #{result.rent}
      <br>
      per: #{parseFloat(result.rent) / result.size}"
    )
    marker.bindPopup(pop)
    points.push marker._latlng
    markers.push marker

  markersGroup = L.layerGroup markers
  markersGroup.addTo(map)

  map.fitBounds(points)

  heatData = []
  for result in apartments
    heatData.push [result.latitude, result.longitude, (parseFloat(result.rent) / result.size)]


  heat = L.heatLayer(heatData, {
    radius: 30,
    blur: 25,
    maxZoom: 17,
  }).addTo(map);
