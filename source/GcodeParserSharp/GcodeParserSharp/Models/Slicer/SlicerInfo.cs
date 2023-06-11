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
        Guid id;
        [ObservableProperty]
        SlicerName slicerName = SlicerName.Unkown;

        [ObservableProperty]
        string installationPath;

        [ObservableProperty]
        string downloadUri;
        [ObservableProperty]
        string repositoryUri;
        #endregion

        #region Override
        public override string ToString() =>  SlicerName.ToString();
        
        public override bool Equals(object obj)
        {
            if (obj is not SlicerInfo item)
                return false;
            return Id.Equals(item.Id) || (this.SlicerName == item.SlicerName);
        }
        public override int GetHashCode() => Id.GetHashCode();
        
        #endregion
    }
}
