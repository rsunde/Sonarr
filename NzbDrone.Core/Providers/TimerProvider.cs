﻿using System;
using System.Timers;
using NLog;

namespace NzbDrone.Core.Providers
{
    public class TimerProvider
    {
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();
        private readonly EpisodeProvider _episodeProvider;
        private readonly MediaFileProvider _mediaFileProvider;

        private readonly Timer _minuteTimer;
        private readonly RssSyncProvider _rssSyncProvider;
        private readonly Timer _rssSyncTimer;
        private readonly SeasonProvider _seasonProvider;
        private readonly SeriesProvider _seriesProvider;
        private DateTime _rssSyncNextInterval;

        public TimerProvider(RssSyncProvider rssSyncProvider, SeriesProvider seriesProvider,
                             SeasonProvider seasonProvider, EpisodeProvider episodeProvider,
                             MediaFileProvider mediaFileProvider)
        {
            _rssSyncProvider = rssSyncProvider;
            _seriesProvider = seriesProvider;
            _seasonProvider = seasonProvider;
            _episodeProvider = episodeProvider;
            _mediaFileProvider = mediaFileProvider;

            _rssSyncTimer = new Timer();
            _minuteTimer = new Timer(60000);
        }

        public virtual void ResetRssSyncTimer()
        {
            double interval = _rssSyncTimer.Interval;
            _rssSyncTimer.Interval = interval;
        }

        public virtual void StartRssSyncTimer()
        {
            if (_rssSyncTimer.Interval < 900000)
                //If Timer is less than 15 minutes, throw an error! This should also be handled when saving the config, though a user could by-pass it by editing the DB directly... TNO (Trust No One)
            {
                Logger.Error("RSS Sync Frequency is invalid, please set the interval first");
                throw new InvalidOperationException("RSS Sync Frequency Invalid");
            }

            _rssSyncTimer.Elapsed += RunRssSync;
            _rssSyncTimer.Start();
            _rssSyncNextInterval = DateTime.Now.AddMilliseconds(_rssSyncTimer.Interval);
        }

        public virtual void StopRssSyncTimer()
        {
            _rssSyncTimer.Stop();
        }

        public virtual void SetRssSyncTimer(int minutes)
        {
            long ms = minutes*60*1000;
            _rssSyncTimer.Interval = ms;
        }

        public virtual TimeSpan RssSyncTimeLeft()
        {
            return _rssSyncNextInterval.Subtract(DateTime.Now);
        }

        public virtual DateTime NextRssSyncTime()
        {
            return _rssSyncNextInterval;
        }

        public virtual void StartMinuteTimer()
        {
            _minuteTimer.Elapsed += MinuteTimer_Elapsed;
            _minuteTimer.Start();
        }

        public virtual void StopMinuteTimer()
        {
            _minuteTimer.Stop();
        }

        private void RunRssSync(object obj, ElapsedEventArgs args)
        {
            _rssSyncNextInterval = DateTime.Now.AddMilliseconds(_rssSyncTimer.Interval);
            _rssSyncProvider.Begin();
        }

        private void MinuteTimer_Elapsed(object obj, ElapsedEventArgs args)
        {
            //Check to see if anything should be run at this time, if so run it

            var now = DateTime.Now;

            //Daily (Except Sunday) 03:00 - Update the lastest season for all TV Shows
            if (now.Hour == 3 && now.Minute == 0 && now.DayOfWeek != DayOfWeek.Sunday)
            {
                foreach (var series in _seriesProvider.GetAllSeries())
                {
                    var season = _seasonProvider.GetLatestSeason(series.SeriesId);
                    _episodeProvider.RefreshEpisodeInfo(season);
                }
            }

            //Sunday 03:00 - Update all TV Shows
            if (now.Hour == 3 && now.Minute == 0 && now.DayOfWeek == DayOfWeek.Sunday)
            {
                foreach (var series in _seriesProvider.GetAllSeries())
                {
                    _episodeProvider.RefreshEpisodeInfo(series.SeriesId);
                }
            }

            //Daily 00:00 (Midnight) - Cleanup (removed) EpisodeFiles + Scan for New EpisodeFiles
            if (now.Hour == 0 && now.Minute == 0)
            {
                foreach (var series in _seriesProvider.GetAllSeries())
                {
                    _mediaFileProvider.CleanUp(series.EpisodeFiles);
                    _mediaFileProvider.Scan(series);
                }
            }

            throw new NotImplementedException();
        }
    }
}