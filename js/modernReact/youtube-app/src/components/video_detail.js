import React from "react";

const VideoDetail = ({ video }) => {
  if (!video) {
    return <div>loading...</div>;
  }

  const videoTitle = video.snippet.title;
  const videoDescrip = video.snippet.description;

  const videoId = video.id.videoId;
  //string interpolation with back ticks
  const videoUrl = `https://www.youtube.com/embed/${videoId}`;

  return (
    <div className="video-detail col-md-8">
      <div className="embed-responsive embed-responsive-16by9">
        <iframe
          src={videoUrl}
          frameBorder="0"
          className="embed-responsive-item"
        />
      </div>
      <div>{videoTitle}</div>
      <div>{videoDescrip}</div>
    </div>
  );
};

export default VideoDetail;
