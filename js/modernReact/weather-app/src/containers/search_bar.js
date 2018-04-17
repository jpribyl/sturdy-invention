import React, { Component } from "react";
import { connect } from "react-redux";
import { bindActionCreators } from "redux";
import { fetchWeather } from "../actions/index";

class SearchBar extends Component {
  //initialize the state
  constructor(props) {
    super(props);

    this.state = { term: "" };

    //take the existing function, bind it to this, replace the existing function
    this.onInputChange = this.onInputChange.bind(this);
    this.onFormSubmit = this.onFormSubmit.bind(this);
  }

  //all DOM event handlers pass an event object (JS thing)
  onInputChange(event) {
    //console.log(event.target.value);
    this.setState({ term: event.target.value });
  }

  onFormSubmit(event) {
    // prevent page refresh
    event.preventDefault();

    // fetch and clear form
    this.props.fetchWeather(this.state.term);
    this.setState({ term: "" });
  }

  render() {
    return (
      // define submit event handler
      <form action="" className="input-group" onSubmit={this.onFormSubmit}>
        <input
          type=""
          placeholder="get a 5 day forcast in your favorite cities"
          className="form-control"
          value={this.state.term}
          onChange={this.onInputChange}
        />
        <span className="input-group-btn">
          <button type="submit" className="btn btn-secondary">
            submit
          </button>
        </span>
      </form>
    );
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchWeather }, dispatch);
}

// pass null because dispatch --> props is always second arg
// first arg is state but this container doesn't care abt state
export default connect(null, mapDispatchToProps)(SearchBar);
