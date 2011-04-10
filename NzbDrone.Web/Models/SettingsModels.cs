﻿using System.Collections.Generic;
using System.ComponentModel;
using NzbDrone.Core.Repository;

namespace NzbDrone.Web.Models
{
    public class SettingsModel
    {
        [DisplayName("TV Series Root Folder(s)")]
        public List<RootDir> Directories { get; set; }
    }
}