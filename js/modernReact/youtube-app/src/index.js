import React, { Component } from "react";
import ReactDOM from "react-dom";
import YTSearch from "youtube-api-search";
import _ from "lodash";

import SearchBar from "./components/search_bar";
import VideoList from "./components/video_list";
import VideoDetail from "./components/video_detail";

//youtube api credentials
const API_KEY = "AIzaSyCAuIUuHZ_Na5na_ZJCYzRQc_iZGfbE9Ow";

//create a new component. it should produce some HTML
//const App = function() {
//return <div>Hi!</div>;
//};

//we can do the same thing using the arrow function
//const App = () => {
//return (
//<div>
//<SearchBar />
//</div>
//);
//};

// method --> class refactor
class App extends Component {
  constructor(props) {
    super(props);

    //we will add the concept of a selected video
    //it will be a video object
    //then pass a callback from app into video-list and then from there to video-list-item
    this.state = {
      videos: [],
      selectedVideo: null,
      searchTerm: ""
    };

    this.videoSearch("surfboards");
  }

  videoSearch(term) {
    //pass an object to the YTSearch
    YTSearch({ key: API_KEY, term: term }, videos => {
      this.setState({
        videos: videos,
        selectedVideo: videos[0]
      }); // this compiles to videos: videos in ES6
    });
  }

  //this is called passing props --> IE passing the prop videos //the
  //videos will arrive as an arg called props
  //we pass 2 props to videoList --> selectedVideo and videos
  //sometimes, it may take a second to load the information and you'll get an undefined element
  //bc state re-renders on changes you can just catch the undefined with a !video and provide txt
  render() {
    //debounce will take the inner function and returns one
    //that can only be called once per 500 miliseconds
    const videoSearch = _.debounce(term => {
      this.videoSearch(term);
    }, 500);

    return (
      <div>
        <SearchBar onSearchTermChange={videoSearch} />
        <VideoDetail video={this.state.selectedVideo} />
        <VideoList
          onVideoSelect={selectedVideo => this.setState({ selectedVideo })}
          videos={this.state.videos}
        />
      </div>
    );
  }
}

//take this component's generated HTML and put it on the page (in the DOM)
ReactDOM.render(<App />, document.querySelector(".container"));

// *note on js modules --> all code that we write in other modules is separated
//IE code in other files has no content with this code unles we explicitly do that.
