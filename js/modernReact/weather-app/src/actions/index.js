import axios from "axios";

const API_KEY = "01cc19714322cfccf0a42e8e980c110a";
const ROOT_URL = `http://api.openweathermap.org/data/2.5/forecast?appid=${API_KEY}`;

export const FETCH_WEATHER = "FETCH_WEATHER";

// city is the search term and we only allow US cities
export function fetchWeather(city) {
  const url = `${ROOT_URL}&q=${city},us`;

  // axios.get() returns a promise while it gets the url
  const request = axios.get(url);

  // redux will stop the request if it hits a promise
  // then it will issue a new request once the promise is resolved
  return {
    type: FETCH_WEATHER,

    // promise as payload
    payload: request
  };
}
