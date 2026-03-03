using AndreasReitberger.Core.Utilities;
using AndreasReitberger.Parser.Gcode.Enums;
using CommunityToolkit.Mvvm.ComponentModel;
using System;

namespace AndreasReitberger.Parser.Gcode.Slicer
{
    public partial class SlicerInfo : BaseModel
    {
        #region Properties
        [ObservableProperty]
        public partial Guid Id { get; set; }

        [ObservableProperty]
        public partial SlicerName SlicerName { get; set; } = SlicerName.Unkown;

        [ObservableProperty]
        public partial string InstallationPath { get; set; }

        [ObservableProperty]
        public partial string DownloadUri { get; set; }

        [ObservableProperty]
        public partial string RepositoryUri { get; set; }
        #endregion

        #region Override
        public override string ToString() =>  SlicerName.ToString();
        
        public override bool Equals(object? obj)
        {
            if (obj is not SlicerInfo item)
                return false;
            return Id.Equals(item.Id) || (SlicerName == item.SlicerName);
        }
        public override int GetHashCode() => Id.GetHashCode();
        
        #endregion
    }
}
