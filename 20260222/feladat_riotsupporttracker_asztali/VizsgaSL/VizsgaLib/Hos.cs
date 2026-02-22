using System;
using System.Collections.Generic;

namespace LolSupportLib;

public partial class Hos
{
    public int HosId { get; set; }

    public string Nev { get; set; } = null!;

    public int SzerepId { get; set; }

    public int NyeresiArany { get; set; }

    public int ValasztasiArany { get; set; }

    public virtual ICollection<Hibajegy> Hibajegies { get; set; } = new List<Hibajegy>();

    public virtual Szerep Szerep { get; set; } = null!;
}
