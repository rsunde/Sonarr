﻿namespace NzbDrone.Core.Providers
{
    public class PostProcessingProvider
    {
        private readonly MediaFileProvider _mediaFileProvider;
        private readonly RenameProvider _renameProvider;
        private readonly SeriesProvider _seriesProvider;

        public PostProcessingProvider(SeriesProvider seriesProvider,
                                      MediaFileProvider mediaFileProvider, RenameProvider renameProvider)
        {
            _seriesProvider = seriesProvider;
            _mediaFileProvider = mediaFileProvider;
            _renameProvider = renameProvider;
        }

        public virtual void ProcessEpisode(string dir, string nzbName)
        {
            var parsedSeries = Parser.ParseSeriesName(nzbName);
            var series = _seriesProvider.FindSeries(parsedSeries);

            if (series == null)
                return;

            //Import the files, and then rename the newly added ones.
            var fileList = _mediaFileProvider.Scan(series, dir);

            foreach (var file in fileList)
            {
                //Notifications will be sent from the Renamer, depending on the bool NewDownload (which will be set to true from here), a normal rename will be treated as such.
                _renameProvider.RenameEpisodeFile(file.EpisodeFileId, true);
            }
        }
    }
}