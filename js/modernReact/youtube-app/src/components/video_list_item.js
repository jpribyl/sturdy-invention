import React from "react";

//{video} is the same as doing const video = props.video;
const VideoListItem = ({ video, onVideoSelect }) => {
  const imageUrl = video.snippet.thumbnails.default.url;
  const videoTitle = video.snippet.title;
  const videoUrl = "https://www.youtube.com/watch?v=" + video.id.videoId;

  return (
    <ul>
      <li onClick={() => onVideoSelect(video)} className="list-group-item">
        <div className="video-list media">
          <div className="media-left">
            <img src={imageUrl} alt="" className="media-object" />
          </div>

          <div className="media-body">
            <div className="media-heading">{videoTitle}</div>
          </div>
        </div>
      </li>
    </ul>
  );
};

export default VideoListItem;
