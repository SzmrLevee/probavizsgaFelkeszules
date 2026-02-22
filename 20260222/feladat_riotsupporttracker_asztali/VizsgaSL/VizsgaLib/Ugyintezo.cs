using System;
using System.Collections.Generic;

namespace LolSupportLib;

public partial class Ugyintezo
{
    public int UgyintezoId { get; set; }

    public string Nev { get; set; } = null!;

    public string Regio { get; set; } = null!;

    public virtual ICollection<Hibajegy> Hibajegies { get; set; } = new List<Hibajegy>();
}
