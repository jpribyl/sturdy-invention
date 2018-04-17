import { FETCH_WEATHER } from "../actions/index";

export default function(state = [], action) {
  switch (action.type) {
    case FETCH_WEATHER:
      //still don't manipulate state directly
      //return state + [action.payload.data];
      return state.concat([action.payload.data]);
    // [ city, city, city ] not [ city, [city, [city]] ]
    //return [action.payload.data, ...state];
    //break;
  }

  return state;
}
