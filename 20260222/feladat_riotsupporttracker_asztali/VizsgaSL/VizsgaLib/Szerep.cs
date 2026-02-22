using System;
using System.Collections.Generic;

namespace LolSupportLib;

public partial class Szerep
{
    public int SzerepId { get; set; }

    public string Megnevezes { get; set; } = null!;

    public virtual ICollection<Hos> Hos { get; set; } = new List<Hos>();
}
