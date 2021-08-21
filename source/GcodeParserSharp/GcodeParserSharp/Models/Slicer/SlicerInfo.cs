using AndreasReitberger.Enums;
using System;

namespace AndreasReitberger.Models
{
    public class SlicerInfo
    {
        #region Properties
        public Guid Id { get; set; }
        public SlicerName SlicerName { get; set; } = SlicerName.Unkown;

        public string InstallationPath { get; set; }

        public string DownloadUri { get; set; }
        #endregion

        #region Override
        public override string ToString()
        {
            return SlicerName.ToString();
        }
        public override bool Equals(object obj)
        {
            if (obj is not SlicerInfo item)
                return false;
            return Id.Equals(item.Id) || (this.SlicerName == item.SlicerName);
        }
        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }
        #endregion
    }
}
