using System;
using System.Collections.Generic;

namespace LolSupportLib;

public partial class Hibajegy
{
    public int HibajegyId { get; set; }

    public int? HosId { get; set; }

    public int? UgyintezoId { get; set; }

    public DateOnly Datum { get; set; }

    public string Statusz { get; set; } = null!;

    public int Sulyossag { get; set; }

    public string Leiras { get; set; } = null!;

    public virtual Hos? Hos { get; set; }

    public virtual Ugyintezo? Ugyintezo { get; set; }
}
