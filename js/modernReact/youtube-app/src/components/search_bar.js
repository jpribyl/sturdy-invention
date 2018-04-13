//this does the same thing as const Component = React.Component
import React, { Component } from "react";

//functional component
//const SearchBar = () => {
//return <input />;
//};

//class component -- used when you want internal record keeping
//so, like a search bar.. where we need to know what a user types
class SearchBar extends Component {
  constructor(props) {
    //calls the parent class constructor (IE component)
    super(props);

    //initializes the state
    this.state = { term: "" };
  }

  onInputChange(term) {
    {
      //abbreviated es6 syntax
      this.setState({ term });
      this.props.onSearchTermChange(term);
    }
  }

  render() {
    return (
      //the only time you ever set a state with an "=" is in the constructor
      //this makes it a controlled component -- IE value only changes when state changes
      <div className="search-bar">
        <input
          value={this.state.term}
          onChange={event => this.onInputChange(event.target.value)}
        />
      </div>
    );
  }

  //this has the same functionality as the arrow function above
  //onInputChange(event) {
  //console.log(event.target.value);
  //}
}

//super important to specify the correct element here
export default SearchBar;

//*note --> in general it's good to start with functional components
//and upgrade to class based when you need the extra functionality

//*state --> a plain js object that is used to record and react to user events
//each class based component has its own state
//any time a state changes, the component re-renders
