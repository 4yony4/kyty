import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAdmin{


  HttpAdmin();


  Future<double> pedirTemperaturasEn(double lat, double lon) async{
    var url = Uri.https('api.open-meteo.com', '/v1/forecast',
        {'latitude': lat.toString(),
          'longitude': lon.toString(),
          'hourly': 'temperature_2m',
        });
    print("URL RESULTANTE: "+url.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //print("MAPA ENTERO: "+jsonResponse.toString());
      var horas = jsonResponse['hourly_units'];
      //print ("UNIDAD HORARIA : "+horas.toString());
      //print ("HORAS : "+jsonResponse['hourly'].toString());
      DateTime now = DateTime.now();
      int hour = now.hour;

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes=jsonHourly['time'];
      var jsonTiempo0=jsonTimes[hour];
      var jsonTemperaturas=jsonHourly['temperature_2m'];
      var jsonTemperatura0=jsonTemperaturas[hour];
      //print("TEMPERATURAS: "+jsonTemperaturas.toString());
      //print("LA TEMPERATURA EN A LAS "+jsonTiempo0.toString()+" FUE "+jsonTemperatura0.toString());
      //print ("TIEMPO : "+jsonHourly['time'].toString());
      //print ("TIEMPO EN LA POSICION 0 : "+jsonResponse['hourly']['time'][0].toString());
      //var itemCount = jsonResponse['totalItems'];
      //print('Number of books about http: $itemCount.');
      //Double.pa
      return jsonTemperatura0;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }

  }



}